Category.delete_all
[
  { id: 1, name: "はったつ" },
  { id: 2, name: "せいしん" },
  { id: 3, name: "め" },
  { id: 4, name: "みみ" },
  { id: 5, name: "てあし" },
  { id: 6, name: "ないぶ" }
].each do |category|
  Category.create(id: category[:id], name: category[:name])
end

Keyword.delete_all
[
  { id: 1, name: "LD", category_id: 1, sequence: 1 },
  { id: 2, name: "ADHD", category_id: 1, sequence: 2 },
  { id: 3, name: "ASD", category_id: 1, sequence: 3 },
  { id: 4, name: "子供", category_id: 1, sequence: 4 },
  { id: 5, name: "大人", category_id: 1, sequence: 5 },
  { id: 6, name: "統合失調症", category_id: 2, sequence: 1 },
  { id: 7, name: "うつ病", category_id: 2, sequence: 2 },
  { id: 8, name: "双極性", category_id: 2, sequence: 3 },
  { id: 9, name: "睡眠", category_id: 2, sequence: 4 },
  { id: 10, name: "高次脳機能", category_id: 2, sequence: 5 },
  { id: 11, name: "知的", category_id: 2, sequence: 6 },
  { id: 12, name: "盲", category_id: 3, sequence: 1 },
  { id: 13, name: "弱視", category_id: 3, sequence: 2 },
  { id: 14, name: "目・先天性", category_id: 3, sequence: 3 },
  { id: 15, name: "目・中途", category_id: 3, sequence: 4 },
  { id: 16, name: "聾", category_id: 4, sequence: 1 },
  { id: 17, name: "難聴", category_id: 4, sequence: 2 },
  { id: 18, name: "耳・先天性", category_id: 4, sequence: 3 },
  { id: 19, name: "耳・中途", category_id: 4, sequence: 4 },
  { id: 20, name: "上肢", category_id: 5, sequence: 1 },
  { id: 21, name: "下肢", category_id: 5, sequence: 2 },
  { id: 22, name: "心疾患", category_id: 6, sequence: 1 },
  { id: 23, name: "アラジール症候群", category_id: 6, sequence: 2 },
  { id: 24, name: "ALS/SMA", category_id: 6, sequence: 3 },
  { id: 25, name: "声帯摘出", category_id: 6, sequence: 4 },
  { id: 26, name: "慢性疲労症候群", category_id: 6, sequence: 5 }
].each do |keyword|
  Keyword.create(id: keyword[:id], name: keyword[:name], category_id: keyword[:category_id], sequence: keyword[:sequence])
end

Page.delete_all
[
  {
    id: 1,
    genre: 1,
    name: "NPO法人みのり",
    status: 1,
    profile_image: "https://ageo-minori.or.jp/wp/wp-content/uploads/2019/11/S__5447682.jpg",
    is_verified: true,
    bio: "はじめまして。「領家グリーンゲイブルズ」施設長の加藤木貢児です。「盲学校卒業後の子どもたちの生活が、”みのり”あるものになることを願って」そんな想いで、2013年5月、盲学校の保護者達によってつくられたみのり。",
    posts_count: 2,
    reviews_count: 2,
    keyword_ids: [ 12, 13, 11, 4 ]
  }
].each do |page|
  p = Page.create(
    id: page[:id],
    genre: page[:genre],
    name: page[:name],
    status: page[:status],
    profile_image: page[:profile_image],
    is_verified: page[:is_verified],
    bio: page[:bio],
    posts_count: page[:posts_count],
    reviews_count: page[:reviews_count],
  )
  page[:keyword_ids].each_with_index do |keyword_id, i|
    p.page_keywords.create(page_id: p.id, keyword_id: keyword_id, sequence: i + 1)
  end
end
