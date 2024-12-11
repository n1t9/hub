return if Rails.env.production?

# user
[
  {
    email: "admin@the-elements.jp",
    password: "password",
    name: "admin",
    display_name: "admin",
    is_admin: true,
    bio: "admin",
    background: "admin",
    url: "",
    language: "ja",
    session_token: "admin",
    followings_count: 0,
    bookmarks_count: 0
  }
].each do |user|
  User.create(
    email: user[:email],
    password: user[:password],
    name: user[:name],
    display_name: user[:display_name],
    is_admin: user[:is_admin],
    bio: user[:bio],
    background: user[:background],
    url: user[:url],
    language: user[:language],
    session_token: user[:session_token],
    followings_count: user[:followings_count],
    bookmarks_count: user[:bookmarks_count]
  )
end

# category
[
  { name: "はったつ", icon: "icon-hattatsu.png", description: "LD、ADHD、ASD、子供、大人", sequence: 1 },
  { name: "せいしん", icon: "icon-seishin.png", description: "統合失調症、うつ病、双極性、睡眠、高次脳機能、知的", sequence: 2 },
  { name: "め", icon: "icon-me.png", description: "盲、弱視、先天性、中途", sequence: 3 },
  { name: "みみ", icon: "icon-mimi.png", description: "聾、難聴、先天性、中途", sequence: 4 },
  { name: "てあし", icon: "icon-teashi.png", description: "上肢、下肢", sequence: 5 },
  { name: "ないぶ", icon: "icon-naibu.png", description: "心疾患、アラジール症候群、ALS/SMA、声帯摘出、慢性疲労症候群", sequence: 6 }
].each do |category|
  Category.create(id: category[:id], name: category[:name], icon: category[:icon], sequence: category[:sequence], description: category[:description])
end

# page
pages = [
  {
    name: "日本視覚障害者団体連合",
    category_id: Category.all[0].id,
    is_verified: true,
    bio: "当アカウントは見えない・見えにくい方とその家族、医療関係者、支援者の方々に情報を発信することを目的としています。",
    url: "http://nichimou.org/",
    posts_count: 2,
    reviews_count: 0,
    profile_image: "shikaku_dantai.jpg"
  },
  {
    name: "株式会社Ashirase",
    category_id: Category.all[0].id,
    is_verified: false,
    bio: "スマートフォンアプリと靴につける振動インターフェースで視覚障害者の歩行をナビゲーションする『あしらせ』",
    url: "https://www.ashirase.com/",
    posts_count: 1,
    reviews_count: 0,
    profile_image: "ashirase.avif"
  },
  {
    name: "AIスーツケース",
    category_id: Category.all[0].id,
    is_verified: false,
    bio: "視覚障害者の移動を支援する自律型ナビゲーションロボット『AIスーツケース』",
    url: "https://www.miraikan.jst.go.jp/research/AccessibilityLab/AIsuitcase/",
    posts_count: 0,
    reviews_count: 0,
    profile_image: "miraikan.png"
  },
  {
    name: "いちほまれ",
    category_id: Category.all[0].id,
    is_verified: false,
    bio: "日本初 #ブラインドeレーサー いちほまれとして #eモータースポーツ の大会に参加中。色々な大会への出場機会をいただく中で #福井県 とこんな #技術士 #視覚障がい者 もいるんだと親近感と興味を持っていただけると嬉しいです！ #網膜色素変性症 #弱視 #白杖",
    url: "",
    posts_count: 0,
    reviews_count: 0,
    profile_image: "ichihomare.webp"
  }
]
def create_pages(pages)
  pages.each do |page|
    Page.create(
      name: page[:name],
      category_id: page[:category_id],
      is_verified: page[:is_verified],
      bio: page[:bio],
      url: page[:url],
      posts_count: page[:posts_count],
      reviews_count: page[:reviews_count],
      profile_image: File.open(Rails.root.join("app/assets/images/#{page[:profile_image]}"))
    )
  end
end
create_pages(pages)
create_pages(pages)
create_pages(pages)

# # page_post
[
  {
    page_id: Page.all[0].id,
    title: "視力の数字が同じでも人によって見え方は違って…",
    content: "鷹林さんは、生まれつき弱視でおられる。弱視と一言で言っても「視力の数字が同じでも人によって見え方は違って、その違いは障害者手帳の等級には表れない」と教えてもらった。\n例えば、鷹林さんは、眼球が痙攣したように動いたり揺れたりする「眼球振盪（がんきゅうしんとう）」という症状をお持ちで、文字が大きくないと見えないだけではなく、「馬」など4本も5本も線があるようなゴチャゴチャした文字を読むことも難しい。
      \n「墨字（すみじ）」という言葉をご存じだろうか？視覚障害者が使用する「点字」に対して、点字ではない文字のことを「墨字」と言う。
      \n盲学校には幼稚部から通っていた鷹林さんは、小学部1年時に先生から「墨字か点字か、どっちを選ぶ？」と聞かれ、その後、カタカナなど独自で習得する努力はしたが「墨字を習うことはなかった」。
      \nそれでも、「社会性を身につけた方がいい」というアドバイスを受けて、同様に挑戦してきた「パイオニアの先輩方がいたので、やってみようと思い」、高校は点字入試で受験し、盲学校から一般校に転じた。
      \nしかし、なにぶん高校生である。中学から友達グループで上がってきたクラスメイトと鷹林さんでは「お互いにどう声をかけていいかわからず、あまり溶け込めなかった」。
      \n鷹林さんの目はぼんやりとは見えるが、相手の顔はわからない。同じ制服が並ぶ中で「誰誰さんいる？なんて自分から口に出せず、相手の声や背の高さやいそうな場所などで何とか反応した」。
      \n勉強の面では、一般校の教科書を視覚障害生徒のために点字に訳してくれるボランティア組織のおかげで同じように学ぶことができた。鷹林さんはそのことに感謝を述べつつ「昔はそうしたボランティアの担い手が多かったからできたけれど、今後10年20年経ったらどうなるか」と、今度は自分に続く後輩が置かれる環境を心配されているようだった。"
  },
  {
    page_id: Page.all[0].id,
    title: "視界は常に真っ白い状態だ…",
    content: "小川さんは先天性の弱視で、右目は小学校の頃に失明した。濃淡の差はあれど視界は常に真っ白い状態だ。
      \n左目は「弱視故のちょっとした不注意だったのか」、36歳の時にロッカーに目をぶつけたことで目の強膜（眼球の外側をつくるいわゆる「しろ目」）が破裂した。角膜移植で一時持ち直すも結局、左目も失明した。視界の色は「（右目同様に）真っ白な時もあれば、真っ黄色だったり赤みがかったりする時もあり」、失明した当初はあった明暗やシルエットは今や失われた。
      \n小川さんは小中学校までは普通校に通っていたが、先天性白内障の後に続発性緑内障（注1）を発症していたこともあり、高校から盲学校（注2）に通われた。「失明しても何とかなるように」白杖（注3）の訓練はもちろん、卒業時には音声でのPC操作もマスターされて、社会福祉法人日本視覚障害者団体連合で働き始めた。
      \n　注1：緑内障とは、ゆっくりと視野が狭まっていき、視野が欠如した部分がぼやけていく、酷くなると失明に至ることもある病気
      \n　注2：盲学校は、従来「養護学校」「ろう学校」と区分してそう呼ばれていたが、現在はその区分はなくなり「特別支援学校」と呼ばれている
      \n　注3：白杖（はくじょう）とは、視覚障害者が歩行の際に前方の路面を触擦するのに使用する白い杖のこと
      \n現在の日常生活でのテクノロジー利用をお聞きすると、第1話の吉泉さん同様の課題感が見えてきた。
      \nまずは移動。晴眼者と同じように「電車の時刻にはYahoo時刻表アプリを使う」し、目的地の方角と距離を教えてくれるアプリ『Blind Square』も使ったことがある。最近では、進路上の障害物や目標物も検出してくれる『Eye Navi』なども出てきているそう。
      "
  },
  {
    page_id: Page.all[1].id,
    title: "自動運転エンジニアから視覚障害への挑戦",
    content: "千野さんは、スマートフォンアプリと靴につける振動インターフェースで視覚障害者の歩行をナビゲーションする『あしらせ』を開発・販売する株式会社Ashiraseの代表をされている。同社は、日本を代表する自動車メーカーであるHondaの新事業創出プログラム「IGNITION（イグニッション）」発のベンチャー企業第1号である。
      \nそのHondaで自動運転の研究開発に携わっていた千野さんが、なぜ視覚障害者の歩行支援をするベンチャー企業を立ち上げるに至ったのか。
      \nきっかけは、義祖母の事故。地方に住むおばあちゃんが買い物の行き帰りで行方不明になり、川に落ちて亡くなっているのが発見される、家族にとってとても痛ましい事故だった。警察官から目が不自由だったことも原因ではないかと指摘された。
      \n千野さんは、この事故をそれだけで終わらせず、技術者ならではの視点でも捉えた。それまで取り組んでいた自動運転は、外的要因との関係で事故を起こさないようにするものだ。他方で、今回のケースは、外的要因もない単独の状態で事故が起きた。「歩行もモビリティであり、そこへのテクノロジーがそこまでない」ことに気付き、「“歩く”を切り口に人の豊かさに貢献しよう」と思い立った。
      \n千野さんがすぐに足を運んだ先は、Hondaが研究所を構える栃木県宇都宮市の地元にある障害者の施設や団体。歩行を支援するのに足に振動を与える発想は最初からもっていた。しかし、それが足の裏だと感じにくかったり、点字ブロックを感じる邪魔にもなる。じゃあ振動を与える先は顔の周りか、手か、鎖骨かと体中を試し、さらには視覚障害者が歩行時に使う補助具の『白杖（はくじょう）』まで。視覚障害者から「白杖は私たちの目です。邪魔されたら嫌ですよね？」と言われながら、当事者が保有する視力レベルや、環境を認識するために重要な聴覚などを踏まえて「完全に邪魔しないインターフェース」を目指した。その結果たどり着いたのが、現在の『あしらせ』の特徴である。
      \nこのインターフェースをもって本格的な製造段階に移行しようと、クラウドファンディングで先行販売に踏み切る。しかし、これまでも視覚障害者へのヒアリングは重ねてきたつもりだったが、実際に販売してお金を払ってもらうとなったときに、それまで課題と思っていたことが「実は課題じゃなかった」。
    "
  }
].each do |page_post|
  PagePost.create(
    id: page_post[:id],
    page_id: page_post[:page_id],
    title: page_post[:title],
    content: page_post[:content]
  )
end

# official_post
official_posts = [
  {
    title: "【横断 #21】キヤスクで描く誰もが好きな服を着られる世界",
    content: "障害や病気があって服をそのまま着れなかったり着づらかったりする方々がいる。でも、
      \n　大好きなアーティストのツアーTシャツを着たい。
      \n　おなじ学校に通うみんなとおなじ制服を着たい。
      \n　お母さんが若いころに着てた思い出のワンピースを着たい。
      \nそんな願いを叶え、服をお直しして「着やすく」するサービス『キヤスク』を立ち上げたのが前田さんだ。
    "
  },
  {
    title: "【こころ #78】障害児のケアと生活と仕事をまわすために",
    content: "障害のあるお子さんのケアと、生活、そして仕事のバランスをとることは容易ではない。
      \n三良さんにとって、娘さんが小学校3年生で精神疾患を発症した当時、二人目の娘さんが生まれたばかりだった。生活面では、日々自宅で長女をケアする中で、まだ赤ん坊の次女は、両親に預けざるを得ず、愛情を注げない。仕事面でも、長女の面倒を見ながら”決められた時間に決められた場所に行く”類の仕事につけるのか。両親も次女の世話のために仕事を調整してくれている一方で、今後保育園に入れるには自分が働いている必要もある。
      \n「この先どうなるのか不安しかなく、長女の発症を機に不幸のらせん階段を下に降りていっている感じでした」
    "
  },
  {
    title: "【こころ #77】子供でも精神疾患になることを知ってほしい",
    content: "あくまで一般的な認識として、統合失調症の発症年齢は10代後半から30代頃がピーク、平均発症年齢は男性では20代半ば前後、女性ではそれよりやや後の年齢と言われる。
      \nでは、小学校3年生（8-9歳）の女の子が、ある日を境に、「友達が家にカメラをしかけている」「お母さんが誰かにさらわれる」といった妄想を口にし始め、ソファから立てない、お風呂に入れない、着替えられない、眠れない、食べても味がしないといった症状が出始めたとしたら、、、
      \nそれが、三良さんが実際に直面した、娘さんの現実だった。三良さんは看護師だった故に、すぐに「統合失調症と同じ症状と認識した」が、病院の認識は違った。
    "
  },
  {
    title: "【けつえき #4】脳卒中患者のために保険外に挑む理学療法士",
    content: "脳卒中（脳血管疾患）は、国内の患者数が174.2万人と推計され（厚生労働省「令和2年患者調査」）、日本でも世界でも4人に1人程度が経験するとも言われる。
      \n一般的に、手足の麻痺や言語障害など障害が残るイメージも強いが、脳卒中の発症直後からのリハビリテーションなどを通じて、職場復帰など回復する場合も少なくない。
      \n針谷さんは、理学療法士を目指す中で、そんな「後遺症が治らないまま生活しなければならない状況を目の当たりにした」ことから、そんな継続サポートがしたいと、脳卒中専門の道に進んだ。
      \n大学卒業後すぐに脳卒中専門の病院に勤めるとともに、自ら学術大会にも通い、貪欲に学んだ。海外の学術大会まで足を運ぶと、「”こうすればよくなる”という明確なエビデンスが出始めている」ことを知り、国内との差を実感することになる。
      例えば、手や高次脳機能のリハビリであれば週5〜7回、足のリハビリであれば週3〜5回など、集中して行えば、発症から時間が経っていたとしても機能が改善する可能性がある。しかし、日本の医療保険の下で、または介護保険の訪問介護として受けられる「保険内」でのリハビリは、制度上、それだけの回数を受けられる形にはなっていない。
    "
  },
  {
    title: "【あし #24 / て #6 / しんけい #25】息子の介護を、他から学び、他に伝える",
    content: "大きな交通事故に遭って意識が半年以上戻らない息子の樹希さんに寄り添い続け、その後の回復過程でも辛い思いをした樹希母さん。その途中で何かしら外に向けて支援を求めることはしなかったのかと聞くと、リアルな答えが返ってきた。
      \n「様々なサポートや相談室や家族会などもあるのですが、その瞬間は目の前の息子を見ることに精一杯で、コンタクトを取るなど行動して相談までするエネルギーがなく、そこまで行きつけないんです」
      \nそうして「自分の中で乗り越えないといけない」と思い頑張ってきたが、やはり先のことなどを誰かに相談できないことは孤独だった。
      \nそんな中で、SNSを通じて、同じような境遇でお子さんを介護する親御さんを調べ、ブログなどに行きつく。
    "
  }
]
def create_official_posts(official_posts)
  official_posts.each do |official_post|
    OfficialPost.create(
      title: official_post[:title],
      content: official_post[:content]
    )
  end
end
create_official_posts(official_posts)
create_official_posts(official_posts)
create_official_posts(official_posts)
create_official_posts(official_posts)
create_official_posts(official_posts)
