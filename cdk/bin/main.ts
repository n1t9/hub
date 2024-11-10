#!/usr/bin/env node
import 'source-map-support/register';
import * as cdk from 'aws-cdk-lib';
import { HubStack } from '../lib/hub-stack';

const app = new cdk.App();
new HubStack(app, 'HubStack', {});
