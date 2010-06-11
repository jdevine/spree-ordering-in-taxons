class ProductTaxon < ActiveRecord::Base
  belongs_to :product
  belongs_to :taxon
  default_scope :order=>'product_taxons.position'
  acts_as_list :scope=>:taxon
end
