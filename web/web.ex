defmodule FamilyFeud.Web do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use FamilyFeud.Web, :controller
      use FamilyFeud.Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def model do
    quote do
      import IEx
      use Ecto.Schema

      alias FamilyFeud.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
    end
  end

  def controller do
    quote do
      import IEx
      use Phoenix.Controller

      alias FamilyFeud.Repo
      import Ecto
      import Ecto.Query

      import FamilyFeud.Router.Helpers
      import FamilyFeud.Gettext

      import FamilyFeud.ApplicationHelper
    end
  end

  def view do
    quote do
      import IEx
      use Phoenix.View, root: "web/templates"

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import FamilyFeud.Router.Helpers
      import FamilyFeud.ErrorHelpers
      import FamilyFeud.Gettext

      import FamilyFeud.ApplicationHelper
    end
  end

  def router do
    quote do
      import IEx
      use Phoenix.Router
    end
  end

  def channel do
    quote do
      import IEx
      use Phoenix.Channel

      alias FamilyFeud.Repo
      import Ecto
      import Ecto.Query
      import FamilyFeud.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
