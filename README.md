# テーブル設計
## usersテーブル
| Column          | Type    | Options                   |
| --------------- | ------- | ------------------------- |
| nickname        | string  | null: false               |
| email           | string  | null: false, unique: true |
| password        | string  | null: false               |
| last_name_jp    | string  | null: false               |
| first_name_jp   | string  | null: false               |
| last_name_kana  | string  | null: false               |
| first_name_kana | string  | null: false               |
| birth_year      | integer | null: false               |
| birth_month     | integer | null: false               |
| birth_day       | integer | null: false               |

### Association
- has_many :items
- has_many :purchaseditems

## itemsテーブル
| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| item_name      | string     | null: false                    |
| description    | text       | null: false                    |
| item_category  | string     | null: false                    |
| item_status    | string     | null: false                    |
| delivery_fee   | string     | null: false                    |
| shipping_from  | string     | null: false                    |
| price          | integer    | null: false                    |
| user           | references | null:false, foreign_keys: true |
| purchased_item | references | null:false, foreign_keys: true |

### Association
belongs_to :user
has_one :purchaseditem

## PurchasedItemsテーブル
| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| user        | references | null:false, foreign_keys: true |
| item        | references | null:false, foreign_keys: true |
| shipping_to | string     | null:false                     |

### Association
belongs_to :user
belongs_to :item