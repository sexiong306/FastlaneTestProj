module Fastlane
  module Actions
    module SharedValues
      UPLOAD_TO_BUGLY_DOWNLOAD_URL = :UPLOAD_TO_BUGLY_DOWNLOAD_URL
    end

    # To share this integration with the other fastlane users:
    # - Fork https://github.com/fastlane/fastlane/tree/master/fastlane
    # - Clone the forked repository
    # - Move this integration into lib/fastlane/actions
    # - Commit, push and submit the pull request

    class UploadToBuglyAction < Action
      def self.run(params)
        require 'json'
        # fastlane will take care of reading in the parameter and fetching the environment variable:
        UI.message "Parameter API Token: #{params[:file_path]}"
        resultFile = File.new("upload_to_bugly_result.json","w+")
        resultFile.close
        json_file = 'upload_to_bugly_result.json'
        cmd = "curl --insecure -F \"file=@#{params[:file_path]}\" -F \"app_id=#{params[:app_id]}\" -F \"pid=#{params[:pid]}\" -F \"title=#{params[:title]}\" -F \"description=#{params[:description]}\" https://api.bugly.qq.com/beta/apiv1/exp?app_key=#{params[:app_key]} -o #{json_file}"
        result = sh(cmd)
        obj = JSON.parse(File.read(json_file))
        ret = obj["rtcode"]  
        if ret == 0
          url = obj["data"]["url"]
          Actions.lane_context[SharedValues::UPLOAD_TO_BUGLY_DOWNLOAD_URL] = url
        end
        # sh "shellcommand ./path"

        # Actions.lane_context[SharedValues::UPLOAD_TO_BUGLY_CUSTOM_VALUE] = "my_val"
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "A short description with <= 80 characters of what this action does"
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "You can use this action to do cool things..."
      end

      def self.available_options
        # Define all options your action supports. 
        
        # Below a few examples
        [
          FastlaneCore::ConfigItem.new(key: :file_path,
                                       env_name: "FL_UPLOAD_TO_BUGLY_FILE_PATH", 
                                       description: "file path for UploadToBuglyAction", 
                                       is_string: true,
                                       default_value: "./file_to_upload_path"
                                       # verify_block: proc do |value|
                                       #    #UI.user_error!("No file path for UploadToBuglyAction given, pass using `file_path: 'path'`") unless (value and not value.empty?)
                                       #    UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                       # end
                                       ),
          FastlaneCore::ConfigItem.new(key: :app_key,
                                       env_name: "FL_UPLOAD_TO_BUGLY_APP_KEY",
                                       description: "app key for UploadToBuglyAction",
                                       is_string: true,
                                       default_value: false
                                       # verify_block: proc do |value|
                                       #    UI.user_error!("No file path for UploadToBuglyAction given, pass using `file_path: 'path'`") unless (value and not value.empty?)
                                       # end
                                       ),
          FastlaneCore::ConfigItem.new(key: :app_id,
                                       env_name: "FL_UPLOAD_TO_BUGLY_APP_ID",
                                       description: "app id for UploadToBuglyAction",
                                       is_string: true, 
                                       default_value: false
                                       # verify_block: proc do |value|
                                       #    UI.user_error!("No file path for UploadToBuglyAction given, pass using `file_path: 'path'`") unless (value and not value.empty?)
                                       # end
                                       ), 
          FastlaneCore::ConfigItem.new(key: :pid,
                                       env_name: "FL_UPLOAD_TO_BUGLY_PID",
                                       description: "pid for UploadToBuglyAction",
                                       is_string: true, 
                                       default_value: true,
                                       # verify_block: proc do |value|
                                       #    UI.user_error!("No file path for UploadToBuglyAction given, pass using `file_path: 'path'`") unless (value and not value.empty)
                                       #    # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                       # end
                                       ), 
          FastlaneCore::ConfigItem.new(key: :title,
                                       env_name: "FL_UPLOAD_TO_BUGLY_TITLE",
                                       description: "title for UploadToBuglyAction",
                                       is_string: true, # true: verifies the input is a string, false: every kind of value
                                       default_value: "体验描述"
                                      ), # the default value if the user didn't provide one
          FastlaneCore::ConfigItem.new(key: :description,
                                       env_name: "FL_UPLOAD_TO_BUGLY_DESCRIPTION",
                                       description: "description for UploadToBuglyAction",
                                       is_string: true, # true: verifies the input is a string, false: every kind of value
                                       default_value: "description"
                                       ), # the default value if the user didn't provide one
          FastlaneCore::ConfigItem.new(key: :secret,
                                       env_name: "FL_UPLOAD_TO_BUGLY_DESCRIPTION",
                                       description: "description for UploadToBuglyAction",
                                       is_string: true, # true: verifies the input is a string, false: every kind of value
                                       default_value: false
                                       ), # the default value if the user didn't provide one
          FastlaneCore::ConfigItem.new(key: :users,
                                       env_name: "FL_UPLOAD_TO_BUGLY_DESCRIPTION",
                                       description: "description for UploadToBuglyAction",
                                       is_string: true, # true: verifies the input is a string, false: every kind of value
                                       default_value: false
                                       ),# the default value if the user didn't provide one
          FastlaneCore::ConfigItem.new(key: :password,
                                       env_name: "FL_UPLOAD_TO_BUGLY_DESCRIPTION",
                                       description: "description for UploadToBuglyAction",
                                       is_string: true, # true: verifies the input is a string, false: every kind of value
                                       default_value: false
                                       )
          # FastlaneCore::ConfigItem.new(key: :download_limit,
          #                              env_name: "FL_UPLOAD_TO_BUGLY_DESCRIPTION",
          #                              description: "description for UploadToBuglyAction",
          #                              is_string: false, # true: verifies the input is a string, false: every kind of value
          #                              default_value: 1000
          #                              )
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['UPLOAD_TO_BUGLY_DOWNLOAD_URL', 'download url'],
          ['FL_UPLOAD_TO_BUGLY_APP_KEY', 'app key'],
          ['FL_UPLOAD_TO_BUGLY_APP_ID', 'app id'],
          ['FL_UPLOAD_TO_BUGLY_TITLE', 'title'],
          ['FL_UPLOAD_TO_BUGLY_DESCRIPTION', 'description']
        ]
      end

      def self.return_value
        # If you method provides a return value, you can describe here what it does
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["sexiong306"]
      end

      def self.is_supported?(platform)
        # you can do things like
        # 
        #  true
        # 
        #  platform == :ios
        # 
        #  [:ios, :mac].include?(platform)
        # 

        platform == :ios
      end
    end
  end
end
