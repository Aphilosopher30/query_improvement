class RequestsController < ApplicationController
  require 'http'

  def input
  end

  def ask

    ask_for_improvement = "Evaluate the clarity, precision, and AI optimization of the following prompt. Identify weaknesses in specificity, structure, and effectiveness. Then, rewrite it for improved clarity, conciseness, and its ability to generate structured, informative, and relevant AI responses. Output only the revised prompt.       "

    question =  params[:question]
    prompt = ask_for_improvement + question

    imrpved_prompt = chat_with_gpt(prompt)

    response = chat_with_gpt(imrpved_prompt)
    render json: { question: question, answer: response }
  end

  def input

  end

  private

  #Future Task: abstract out the api call
  def chat_with_gpt(question)

    api_key = ENV['gpt_key']
    response = HTTP.post(
      "https://api.openai.com/v1/chat/completions",
      headers: {
        "Authorization" => "Bearer #{api_key}",
        "Content-Type" => "application/json"
      },
      json: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: question }]
      }
    )

    json_response = response.parse
    json_response.dig("choices", 0, "message", "content") || "No response"
  end
end
