Puppet::Type.newtype(:array_fragment) do
  @doc = <<-DOC
    @summary
      Manages the fragment.

    @example
      # The example is based on exported resources.

      concat_fragment { \"uniqe_name_${::fqdn}\":
        tag => 'unique_name',
        order => 10, # Optional. Default to 10
        content => 'some content' # OR
        # content => template('template.erb')
        source  => 'puppet:///path/to/file'
      }
  DOC

  newparam(:name, namevar: true) do
    desc 'Name of resource.'
  end

  newparam(:array) do
    desc <<-DOC
      Required. Specifies the destination file of the fragment. Valid options: a string containing the path or title of the parent
      concat_file resource.
    DOC

    validate do |value|
      raise ArgumentError, _('Target array must be a String') unless value.is_a?(String)
    end
  end

  newparam(:valuie) do
    desc <<-DOC
      Supplies the content of the fragment. Note: You must supply either a content parameter or a source parameter. Valid options: a string
    DOC

    validate do |value|
      raise ArgumentError, _('Value must be a String') unless value.is_a?(String)
    end
  end

end
