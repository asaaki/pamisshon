# encoding: utf-8

# https://github.com/rails/rails/commit/29a5aeaae976bf8432d57ec996c7c81932a39de6#activesupport/lib/active_support/core_ext/object/try.rb

class Object
  # Invokes the method identified by the symbol +method+, passing it any arguments
  # and/or the block specified, just like the regular Ruby <tt>Object#send</tt> does.
  #
  # *Unlike* that method however, a +NoMethodError+ exception will *not* be raised
  # and +nil+ will be returned instead, if the receiving object is a +nil+ object or NilClass.
  #
  # If try is called without a method to call, it will yield any given block with the object.
  #
  # ==== Examples
  #
  # Without +try+
  #   @person && @person.name
  # or
  #   @person ? @person.name : nil
  #
  # With +try+
  #   @person.try(:name)
  #
  # +try+ also accepts arguments and/or a block, for the method it is trying
  #   Person.try(:find, 1)
  #   @people.try(:collect) {|p| p.name}
  #
  # Without a method argument try will yield to the block unless the receiver is nil.
  #   @person.try { |p| "#{p.first_name} #{p.last_name}" }
  #--
  # +try+ behaves like +Object#send+, unless called on +NilClass+.
  def try(*a, &b)
    if a.empty? && block_given?
      yield self
    elsif !a.empty? && !respond_to?(a.first)
      nil
    else
      __send__(*a, &b)
    end
  end
end

