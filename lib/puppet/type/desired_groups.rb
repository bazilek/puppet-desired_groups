Puppet::Type.newtype(:desired_groups) do
    @doc = "Adding user to existing system groups. Do nothing if group does not exist."

    desc "Adding user only to existing unix groups. Desired groups passed as parameter."

    autorequire(:user) do
        self[:name]
    end

    newparam(:name) do
        desc "The name of the user."
    end

    newproperty(:groups, :array_matching => :all) do
        desc "Desired groups list."

        # just pretty output on change methods
        def is_to_s( currentvalue )
            currentvalue.compact.join(',')
        end

        def should_to_s( newvalue )
            newvalue.compact.join(',')
        end

        # helper method
        def get_existing_groups
            groups = []
            # reset group iterator
            Etc.setgrent
            Etc.group {|g|
                groups << g.name
            }
            Etc.endgrent
            groups
        end

        # skip groups that does not exist
        munge do |group|
            if get_existing_groups.include? group
                group
            end
        end
    end
end
