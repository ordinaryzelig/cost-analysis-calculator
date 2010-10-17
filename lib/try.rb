class Object

  # customized version of Rails' try method.
  # this also needs to rescue NoMethodErrors because of how Calculator defines methods through attributes.
  def try(method_name, *args, &block)
    send(method_name, *args, &block)
  rescue NoMethodError
    nil
  end

end
