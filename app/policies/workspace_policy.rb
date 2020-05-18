# frozen_string_literal: true

# Workspace Policy
class WorkspacePolicy < ApplicationPolicy
  # Custom workspace scope
  class Scope < Scope
    def resolve
      scope.where(id: user.workspaces)
    end
  end
end
