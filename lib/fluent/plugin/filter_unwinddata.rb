#
# Copyright 2022- TODO: Write your name
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "fluent/plugin/filter"

module Fluent
  module Plugin
    class UnwinddataFilter < Fluent::Plugin::Filter
      Fluent::Plugin.register_filter("unwinddata", self)
      helpers :event_emitter

      config_param :unwind_key, :string, default: nil

      def configure(conf)
      super
      REQUIRED_PARAMS.each do |param|
        unless config.has_key?(param)
          raise Fluent::ConfigError, "#{param} field is required"
        end
      end
    end


      def filter(tag, time, record)
        if record[unwind_key] && record[unwind_key].is_a?(Array)
          record[unwind_key].each do |value|
            new_record = record.dup
            new_record[unwind_key] = value
            router.emit(tag, time, new_record)
          end
        else
          router.emit(tag, time, record)
        end
      end
    end
  end
end
