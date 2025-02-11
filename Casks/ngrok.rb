cask "ngrok" do
  arch arm: "arm64", intel: "amd64"

  on_intel do
    version "3.1.1,ewxEwpSWPaS,a"
    sha256 "c69ef74f6a06a3b26635043546e9d832e6222ca8994ff3f0a8927639d9729f3b"
  end
  on_arm do
    version "3.1.1,an2KvqCaZyY,a"
    sha256 "d73dbaef1cbb9f33933f901d81796cf1781b2ab36555d1cd4b3fbf11bd8a0778"
  end

  url "https://bin.equinox.io/#{version.csv.third}/#{version.csv.second}/ngrok-v#{version.major}-#{version.csv.first}-stable-darwin-#{arch}.zip",
      verified: "bin.equinox.io/"
  name "ngrok"
  desc "Reverse proxy, secure introspectable tunnels to localhost"
  homepage "https://ngrok.com/"

  livecheck do
    url "https://dl.equinox.io/ngrok/ngrok-v#{version.major}/stable/archive"
    regex(%r{href=.*?/([^/]+)/([^/]+)/ngrok[._-]v#{version.major}[._-]v?(\d+(?:\.\d+)+)[._-]darwin[._-]#{arch}\.zip}i)
    strategy :page_match do |page|
      page.scan(regex).map { |match| "#{match[2]},#{match[1]},#{match[0]}" }
    end
  end

  binary "ngrok"

  postflight do
    set_permissions "#{staged_path}/ngrok", "0755"
  end

  zap trash: [
    "~/.ngrok#{version.major}",
    "~/Library/Application Support/ngrok",
  ]
end
