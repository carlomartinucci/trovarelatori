class GoogleKnowledgeGraph
  include HTTParty
  base_uri 'https://kgsearch.googleapis.com/v1/entities:search'

  def initialize(query, limit=5)
    @request = self.class.get "",
      query: {
        key: "AIzaSyCblPOugcd1BCker5Y9Tgz-m2rrg0tF_IA",
        query: query,
        languages: "it",
        prefix: true,
        limit: limit
      }
    @json = JSON.parse @request.response.body
  end

  def json
    @json
  end

  def list
    @json["itemListElement"].map{|e|e["result"]["name"]}.compact
  end
end


