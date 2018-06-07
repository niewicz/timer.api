class CreateBillingProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :billing_profiles do |t|
      t.belongs_to  :user,                        index: true
      t.string      :email,         null: false  
      t.string      :person_name,   null: false
      t.string      :company_name 
      t.string      :phone 
      t.string      :address 
      t.string      :city 
      t.string      :postal_code 
      t.string      :country 
      t.string      :account_owner 
      t.string      :iban 
      t.string      :swift_code 
      t.string      :currency 
      
      t.timestamps
    end
  end
end
