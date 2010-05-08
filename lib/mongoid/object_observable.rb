# encoding: utf-8
module Mongoid #:nodoc:
  module ObjectObservable #:nodoc:
    extend ActiveSupport::Concern
    included do
      attr_reader :object_observers
    end

    # Add an object observer to this object. This mimics the standard Ruby
    # observable library.
    #
    # Example:
    #
    # <tt>address.add_object_observer(person)</tt>
    def add_object_observer(object)
      @object_observers ||= []
      @object_observers.push(object)
    end

    # Notify all the objects observing this object of an update. All observers
    # need to respond to the update method in order to handle this.
    #
    # Example:
    #
    # <tt>document.notify_object_observers(self)</tt>
    def notify_object_observers(*args)
      @object_observers.dup.each { |observer| observer.object_observe(*args) } if @object_observers
    end
  end
end
