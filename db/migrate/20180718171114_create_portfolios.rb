class CreatePortfolios < ActiveRecord::Migration[5.1]
  def change
    create_table :portfolios do |t|
      t.string :cryptocurrency
      t.numeric :amount
      t.string :date_of_purchase
      t.string :wallet_location
      t.decimal :current_market_value,  :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
