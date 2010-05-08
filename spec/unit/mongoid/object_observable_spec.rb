require "spec_helper"

describe Mongoid::ObjectObservable do

  let(:person) do
    Person.new
  end

  let(:address) do
    Address.new
  end

  describe "#add_object_observer" do

    it "adds an observer to the object_observers array" do
      address.add_object_observer(person)
      address.object_observers.first.should == person
    end
  end

  describe "#notify_object_observers" do

    before do
      address.add_object_observer(person)
    end

    context "when object_observers exist" do

      it "calls update on each object_observer with the args" do
        person.expects(:object_observe).with("Testing")
        address.notify_object_observers("Testing")
      end
    end

    context "when no object_observers are set up" do

      before do
        @name = Name.new
      end

      it "does notthing" do
        @name.notify_object_observers("Testing")
      end
    end
  end
end
