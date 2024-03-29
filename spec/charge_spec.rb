require './lib/charge'

describe Charge do
  context 'journey within one zone only' do
    it 'touch in in zone 1, touch out zone 1, charged 1' do
      s1 = Station.new("Bank", 1)
      s2 = Station.new("Angel", 1)
      charge = Charge.new(s1, s2)
      expect(charge.amount).to eq 1
    end
  end

  context 'journey from zone 1 to zone 2' do
    it 'touch in in zone 1, touch out zone 2, charged 2' do
      s1 = Station.new("Bank", 1)
      s3 = Station.new("Wapping", 2)
      charge = Charge.new(s1, s3)
      expect(charge.amount).to eq 2
    end
  end

  context 'journey from zone 1 to zone 3' do
    it 'touch in in zone 1, touch out zone 2, charged 2' do
      s1 = Station.new("Bank", 1)
      s3 = Station.new("Archway", 3)
      charge = Charge.new(s1, s3)
      expect(charge.amount).to eq 3
    end
  end

  context "Penatly fare" do

    it "gives penalty for double touch in" do
      s1 = Station.new("Bank", 1)
      s2 = nil
      
      charge = Charge.new(s1, s2)
      expect(charge.amount).to eq 6
    end
  end

  context "Penatly fare" do

    it "touching out without touching in" do
      s1 = Station.new("Bank", 1)
      s2 = nil
      
      charge = Charge.new(s2, s1) # charge could have kwords
      expect(charge.amount).to eq 6
    end
  end
end

=begin
Penalty fare = 6
Penalty when no touch in or no touch out, but other happens
Same zone charge = 1
+ 1 for each boundary crossed
=end