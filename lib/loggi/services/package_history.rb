# frozen_string_literal: true

module Loggi
  module Services
    class PackageHistory < Base
      class WithoutPackageHistory < StandardError; end

      attr_accessor :pk

      def initialize(options)
        super()
        @pk = options[:pk]
      end

      def get
        response = request!
        package_history = response[:packageHistory]
        raise WithoutPackageHistory unless package_history

        package_history
      end

      def login_required?
        true
      end

      def query
        <<-QUERY
          query {
            packageHistory(packageId: #{@pk}, forCompany: true) {
              signatureUrl
              signedByName
              statuses {
                status
                statusDisplay
                detailedStatusDisplay
                statusCode
                updated
              }
            }
          }
        QUERY
      end
    end
  end
end
