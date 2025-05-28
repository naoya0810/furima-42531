class Content < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '音楽' },
    { id: 3, name: '映画' },
    { id: 4, name: '書籍' },
    { id: 5, name: 'ゲーム' }
    # 必要に応じて項目を追加してください
  ]

  include ActiveHash::Associations
  has_many :items
end
