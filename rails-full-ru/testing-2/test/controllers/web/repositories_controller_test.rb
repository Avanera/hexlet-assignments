# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @repository_params = {
      link: 'https://example.com/repo',
      owner_name: 'owner',
      repo_name: 'repo',
      description: 'A description',
      default_branch: 'main',
      watchers_count: 10,
      language: 'Ruby',
      repo_created_at: Time.now,
      repo_updated_at: Time.now
    }

    @repository = Repository.new(@repository_params)

    # Создаем заглушку для сервиса
    @service = Minitest::Mock.new
    @service.expect(:call, @repository_params, ['https://example.com/repo'])

    # Заменяем экземпляр сервиса на наш мок
    Web::RepositoryDataBuilderService.stub :new, @service do
      yield if block_given?
    end
  end

  test 'should create repository' do
    # Используем @service в тесте
    Web::RepositoryDataBuilderService.stub :new, @service do
      assert_difference('Repository.count') do
        post repositories_url, params: { repository: { link: 'https://example.com/repo' } }
      end

      assert_redirected_to repositories_path
      assert_equal 'Success message', flash[:notice]
    end
  end
end
