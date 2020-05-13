require 'puppet/type/file/owner'
require 'puppet/type/file/group'
require 'puppet/type/file/mode'
require 'puppet/util/checksums'

Puppet::Functions.create_function((:concat_function) do
  @doc = <<-DOC
    @summary
      Generates a file with content from fragments sharing a common unique tag.

    @example
      Concat_fragment <<| tag == 'unique_tag' |>>

      concat_file { '/tmp/file':
        tag            => 'unique_tag', # Optional. Default to undef
        path           => '/tmp/file',  # Optional. If given it overrides the resource name
        owner          => 'root',       # Optional. Default to undef
        group          => 'root',       # Optional. Default to undef
        mode           => '0644'        # Optional. Default to undef
        order          => 'numeric'     # Optional, Default to 'numeric'
        ensure_newline => false         # Optional, Defaults to false
      }
  DOC

  dispatch :collect do
    param 'String', :target_array
  end

  def collect(target_array)
    # Collect elements which belong to the given target.
    catalog.resources.map { |resource|
      next unless resource.is_a?(Puppet::Type.type(:distributed_array_element))

      if resource[:array] == target_array
        resource[:value]
      end
    }.compact
  end
end
