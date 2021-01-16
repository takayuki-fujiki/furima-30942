# テーブル設計
## usersテーブル
| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| last_name_jp       | string  | null: false               |
| first_name_jp      | string  | null: false               |
| last_name_kana     | string  | null: false               |
| first_name_kana    | string  | null: false               |
| birthday           | date    | null: false               |

### Association
- has_many :items
- has_many :purchaseditems

## itemsテーブル
| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| item_name           | string     | null: false                    |
| description         | text       | null: false                    |
| item_category_id    | integer    | null: false                    |
| item_status_id      | integer    | null: false                    |
| delivery_fee_id     | integer    | null: false                    |
| prefecture_id       | integer    | null: false                    |
| days_to_shipping_id | integer    | null: false                    |
| price               | integer    | null: false                    |
| user                | references | null:false, foreign_keys: true |

### Association
belongs_to :user
has_one :purchaseditem

## PurchasedItemsテーブル
| Column      | Type       | Options                         |
| ----------- | ---------- | ------------------------------- |
| user        | references | null: false, foreign_keys: true |
| item        | references | null: false, foreign_keys: true |

### Association
belongs_to :user
belongs_to :item
has_one :shippingto

## ShippngToテーブル
| Column         | Type       | Options                         |
| -------------- | ---------- | ------------------------------- |
| purchased_item | references | null: false, foreign_keys: true |
| postal_code    | integer    | null: false                     |
| prefecture_id  | string     | null: false                     |
| city           | string     | null: false                     |
| address        | string     | null: false                     |
| building       | string     |                                 |
| phone_number   | string     | null: false                     |

### Association
belongs_to :purchaseditem