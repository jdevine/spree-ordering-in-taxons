require File.dirname(__FILE__) + '/../spec_helper'

describe ProductTaxon do
  before(:each) do
    @product_taxon = ProductTaxon.new
  end

  it "should be valid" do
    @product_taxon.should be_valid
  end
end
