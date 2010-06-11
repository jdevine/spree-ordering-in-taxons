= Ordering In Taxons

Simple, untested extention to order products within a taxon (thereby controlling which show up on the front page of a taxon page).

Changes include: 
  - new "product_taxons" table with migration and ProductTaxon class with position column, acts_as_list :scope=>:taxon 
  - changed product.taxons to has_many :through from has_and_belongs_to_many
  - overrode Product.available named scope to add include=>:product_taxons, :order=>'product_taxons.position'
  - added sortable list of products to the taxon edit page (right click the taxon and choose edit to get there)
