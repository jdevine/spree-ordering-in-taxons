# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class OrderingInTaxonsExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/ordering_in_taxons"

  # Please use ordering_in_taxons/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate

    Product.class_eval do
      has_many :product_taxons
      has_many :taxons, :through=>:product_taxons

      #default_scope :include=>:product_taxons, :order=>"product_taxons.position"
      named_scope :ordered, {:include=>:product_taxons, :order=>"product_taxons.position"}

      named_scope :available, lambda { |*args| 
          { :conditions => ["products.available_on <= ?", args.first || Time.zone.now], 
            :order => 'product_taxons.position',
            :include=>:product_taxons
          } 
      } 

    end

    Taxon.class_eval do
      has_many :product_taxons,:order=>'product_taxons.position'
      has_many :products, :through=>:product_taxons, :order=>'product_taxons.position'
    end


    Admin::TaxonsController.class_eval do
      def reorder_products
        params[:product_taxons].each_with_index do |ptid, idx|
          pt = ProductTaxon.find(ptid.to_i)
          pt.insert_at(idx)
        end
        head :created
      end
    end

    # make your helper avaliable in all views
    # Spree::BaseController.class_eval do
    #   helper YourHelper
    # end
  end
end
