# frozen_string_literal: true

module RailsAssetslessContainer
  module Strategy
    class AssetServer < Base
      def initialize(
        asset_host: nil,
        suffix: ENV["SHA"],
        retry_count: 3,
        retry_wait: 1
      )
        @asset_host = asset_host
        @suffix = suffix
        @retry_count = retry_count
        @retry_wait = retry_wait
      end

      def after_sprockets(path)
        FileUtils.copy(path, public_dir.join(sprockets_manifest_path))
      end

      def after_webpacker(path)
        FileUtils.copy(path, public_dir.join(webpacker_manifest_path))
      end

      def write_sprockets_manifest(path)
        uri = build_manifest_uri(sprockets_manifest_path)
        mkdir(path)
        File.write(path, download_with_retry(uri))
      end

      def write_webpacker_manifest(path)
        uri = build_manifest_uri(webpacker_manifest_path)
        mkdir(path)
        File.write(path, download_with_retry(uri))
      end

      private

      attr_reader :suffix, :retry_count, :retry_wait

      def public_dir
        Rails.root.join("public")
      end

      def asset_host
        @asset_host ||= Rails.application.config.asset_host
      end

      def sprockets_manifest_path
        "assets/.sprockets-manifest-#{suffix}.json"
      end

      def webpacker_manifest_path
        "packs/manifest-#{suffix}.json"
      end

      def mkdir(path)
        Pathname(path).dirname.mkpath
      end

      def build_manifest_uri(path)
        scheme = "https://" unless asset_host.start_with?("http")
        URI.parse("#{scheme}#{asset_host}/#{path}")
      end

      def download_with_retry(uri)
        with_retry do
          res = Net::HTTP.get_response(uri)
          raise("#{res.code}: #{res.body}") if res.code != "200"

          res.body
        end
      end

      def with_retry
        count = 0

        begin
          yield
        rescue StandardError => e
          count += 1
          raise(e) if count >= retry_count

          sleep(retry_wait) if retry_wait.positive?
          retry
        end
      end
    end
  end
end
