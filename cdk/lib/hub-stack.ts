import * as cdk from 'aws-cdk-lib';
import { Construct } from 'constructs';

export class HubStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const imageTag = '2024-12-23-14-58-2e9cf9d';

    const acmArn = 'arn:aws:acm:ap-northeast-1:442426895348:certificate/712c6011-f972-4ccf-8be0-710e4c8cde57';

    const vpc = new cdk.aws_ec2.Vpc(this, 'VPC', {
      vpcName: 'HubVPC',
      ipAddresses: cdk.aws_ec2.IpAddresses.cidr('10.0.0.0/16'),
      maxAzs: 3,
      natGateways: 0,
      subnetConfiguration: [
        {
          name: 'Public',
          subnetType: cdk.aws_ec2.SubnetType.PUBLIC,
          cidrMask: 20,
        },
        {
          name: 'Private',
          subnetType: cdk.aws_ec2.SubnetType.PRIVATE_ISOLATED,
          cidrMask: 20,
        },
      ],
    });

    const ecr = new cdk.aws_ecr.Repository(this, 'ECR', {
      repositoryName: 'hub',
    });

    const rdsSecurityGroup = new cdk.aws_ec2.SecurityGroup(this, 'RDSSecurityGroup', {
      vpc,
      securityGroupName: 'RDS Security Group',
      description: 'Allow inbound traffic from VPC',
      allowAllOutbound: true,
    });
    rdsSecurityGroup.addIngressRule(
      cdk.aws_ec2.Peer.ipv4(vpc.vpcCidrBlock),
      cdk.aws_ec2.Port.tcp(5432),
      'Allow inbound traffic from VPC'
    );

    const rds = new cdk.aws_rds.DatabaseInstance(this, 'RDS', {
      vpc,
      vpcSubnets: {
        subnetType: cdk.aws_ec2.SubnetType.PRIVATE_ISOLATED,
      },
      publiclyAccessible: false,
      engine: cdk.aws_rds.DatabaseInstanceEngine.postgres({
        version: cdk.aws_rds.PostgresEngineVersion.VER_16_4,
      }),
      instanceType: cdk.aws_ec2.InstanceType.of(
        cdk.aws_ec2.InstanceClass.M7G,
        cdk.aws_ec2.InstanceSize.LARGE,
      ),
      securityGroups: [rdsSecurityGroup],
      allocatedStorage: 50,
      databaseName: 'hub',
      multiAz: true,
      storageEncrypted: true,
      backupRetention: cdk.Duration.days(14),
      preferredBackupWindow: '03:00-04:00',
      allowMajorVersionUpgrade: false,
      autoMinorVersionUpgrade: true,
      deleteAutomatedBackups: true,
      enablePerformanceInsights: true,
      deletionProtection: true,
    });

    const bastionSecurityGroup = new cdk.aws_ec2.SecurityGroup(this, 'BastionSecurityGroup', {
      vpc,
      securityGroupName: 'Bastion Security Group',
      description: 'For Bastion Host',
      allowAllOutbound: true,
    });
    bastionSecurityGroup.addIngressRule(
      cdk.aws_ec2.Peer.ipv4('118.237.200.240/32'),
      cdk.aws_ec2.Port.tcp(22),
      'Allow inbound traffic from my IP'
    );

    const bastion = new cdk.aws_ec2.BastionHostLinux(this, 'Bastion', {
      vpc,
      instanceName: 'hub-bastion',
      subnetSelection: {
        subnetType: cdk.aws_ec2.SubnetType.PUBLIC,
      },
      instanceType: cdk.aws_ec2.InstanceType.of(
        cdk.aws_ec2.InstanceClass.T3,
        cdk.aws_ec2.InstanceSize.MICRO,
      ),
      securityGroup: bastionSecurityGroup,
    });

    const s3 = new cdk.aws_s3.Bucket(this, 'S3', {
      bucketName: 'hub-' + this.account + '-' + this.region,
      versioned: true,
      removalPolicy: cdk.RemovalPolicy.RETAIN,
    });

    const cluster = new cdk.aws_ecs.Cluster(this, 'Cluster', {
      vpc,
      clusterName: 'hub',
    });

    const taskDefinition = new cdk.aws_ecs.FargateTaskDefinition(this, 'TaskDefinition', {
      cpu: 512,
      memoryLimitMiB: 1024,
      runtimePlatform: {
        operatingSystemFamily: cdk.aws_ecs.OperatingSystemFamily.LINUX,
        cpuArchitecture: cdk.aws_ecs.CpuArchitecture.X86_64,
      },
    });

    const dbSecret = rds.secret!;
    const container = taskDefinition.addContainer('Container', {
      image: cdk.aws_ecs.ContainerImage.fromEcrRepository(
        ecr,
        imageTag,
      ),
      memoryLimitMiB: 512,
      logging: new cdk.aws_ecs.AwsLogDriver({
        streamPrefix: 'hub',
        logRetention: cdk.aws_logs.RetentionDays.TWO_YEARS,
      }),
      secrets: {
        DB_HOST: cdk.aws_ecs.Secret.fromSecretsManager(dbSecret, 'host'),
        DB_PORT: cdk.aws_ecs.Secret.fromSecretsManager(dbSecret, 'port'),
        DB_NAME: cdk.aws_ecs.Secret.fromSecretsManager(dbSecret, 'dbname'),
        DB_USERNAME: cdk.aws_ecs.Secret.fromSecretsManager(dbSecret, 'username'),
        DB_PASSWORD: cdk.aws_ecs.Secret.fromSecretsManager(dbSecret, 'password'),
      },
      environment: {
        S3_BUCKET: s3.bucketName,
        IMAGE_TAG: imageTag,
        RAILS_ENV: 'production',
        SECRET_KEY_BASE: '0cbdb6e89425dc3fff37d132b4f172aff18c01efe884c805e62246a3342c4d91',
      },
      portMappings: [
        {
          containerPort: 3000,
          hostPort: 3000,
        },
      ],
    });

    const serviceSecurityGroup = new cdk.aws_ec2.SecurityGroup(this, 'ServiceSecurityGroup', {
      vpc,
      securityGroupName: 'Service Security Group',
      allowAllOutbound: true,
    });

    const service = new cdk.aws_ecs.FargateService(this, 'Service', {
      cluster,
      serviceName: 'hub',
      taskDefinition,
      desiredCount: 2,
      assignPublicIp: true,
      securityGroups: [serviceSecurityGroup],
      vpcSubnets: {
        subnetType: cdk.aws_ec2.SubnetType.PUBLIC,
      },
      platformVersion: cdk.aws_ecs.FargatePlatformVersion.VERSION1_4,
      enableExecuteCommand: true,
    });
    s3.grantReadWrite(service.taskDefinition.taskRole);

    const albSecurityGroup = new cdk.aws_ec2.SecurityGroup(this, 'ALBSecurityGroup', {
      vpc,
      securityGroupName: 'ALB Security Group',
      allowAllOutbound: true,
    });

    const alb = new cdk.aws_elasticloadbalancingv2.ApplicationLoadBalancer(this, 'ALB', {
      vpc,
      internetFacing: true,
      loadBalancerName: 'hub',
      securityGroup: albSecurityGroup,
    });

    const targetGroup = new cdk.aws_elasticloadbalancingv2.ApplicationTargetGroup(this, 'TargetGroup', {
      vpc,
      targetGroupName: 'hub',
      protocol: cdk.aws_elasticloadbalancingv2.ApplicationProtocol.HTTP,
      targetType: cdk.aws_elasticloadbalancingv2.TargetType.IP,
      deregistrationDelay: cdk.Duration.seconds(60),
      port: 3000,
      healthCheck: {
        path: '/health_check',
        protocol: cdk.aws_elasticloadbalancingv2.Protocol.HTTP,
        healthyHttpCodes: '200',
        interval: cdk.Duration.seconds(10),
        timeout: cdk.Duration.seconds(5),
        healthyThresholdCount: 2,
        unhealthyThresholdCount: 2,
      },
    });
    targetGroup.addTarget(service);

    const listener = alb.addListener('Listener', {
      port: 443,
      protocol: cdk.aws_elasticloadbalancingv2.ApplicationProtocol.HTTPS,
      certificates: [
        {
          certificateArn: acmArn,
        },
      ],
      defaultTargetGroups: [targetGroup],
      open: true,
    });
  }
}
