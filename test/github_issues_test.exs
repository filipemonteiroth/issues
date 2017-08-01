defmodule IssuesTest do
  use ExUnit.Case

  test "issues url returns a github api url with user and project" do
    assert Issues.GithubIssues.issues_url("filipemonteiroth", "issues") == "https://api.github.com/repos/filipemonteiroth/issues/issues"
  end

  test "when response receives 200, it should return ok and decoded json body" do
    
    {status, body} = Issues.GithubIssues.handle_response(%{status_code: 200, body: """
      {'repo': 1, 'issues': 0} 
      """ 
    })

    assert status == :ok
    assert body == [{"repo", 1}, {"issues", 0}]
  end

  test "when response receives other status code, it should return error and decoded json body" do
    {status, body} = Issues.GithubIssues.handle_response(%{status_code: 500, body: """
      {'repo': 0, 'issues': 0} 
      """ 
    })

    assert status == :error
    assert body == [{"repo", 0}, {"issues", 0}]
  end

end
