class GistClient
  def initialize
    @client = Octokit::Client.new
  end

  def content(gist_id)
    @client.gist(gist_id).files
  end
end
