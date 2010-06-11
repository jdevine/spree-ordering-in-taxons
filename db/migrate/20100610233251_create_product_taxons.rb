class CreateProductTaxons < ActiveRecord::Migration
  def self.up
    create_table :product_taxons do |t|
      t.timestamps
      t.integer 'product_id'
      t.integer 'taxon_id'
      t.integer 'position', :default=>1
    end

    # turn products_taxons into product_taxons with an initial order...
    #
    ActiveRecord::Base.connection.
     execute("select product_id, taxon_id from products_taxons order by taxon_id, product_id").
     each do |res|
      p = ProductTaxon.new(res);
      p.save
    end
  
   end

    def self.down
      drop_table :product_taxons
    end
  end
