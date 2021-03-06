require 'spec_helper'

describe Barcode do
	it { should validate_presence_of(:code) }
	it { should validate_presence_of(:store_item) }
	it { should validate_uniqueness_of(:code) }
	it { should belong_to(:store_item) }
end
