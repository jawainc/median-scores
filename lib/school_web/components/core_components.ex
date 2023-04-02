defmodule SchoolWeb.CoreComponents do
  @moduledoc """
  Provides core UI components.

  The components in this module use Tailwind CSS, a utility-first CSS framework.
  See the [Tailwind CSS documentation](https://tailwindcss.com) to learn how to
  customize the generated components in this module.

  Icons are provided by [heroicons](https://heroicons.com), using the
  [heroicons_elixir](https://github.com/mveytsman/heroicons_elixir) project.
  """
  use Phoenix.Component

  alias Phoenix.LiveView.JS
  import SchoolWeb.Gettext

  @doc """
  Renders a modal.

  ## Examples

      <.modal id="confirm-modal">
        Are you sure?
        <:confirm>OK</:confirm>
        <:cancel>Cancel</:cancel>
      </.modal>

  JS commands may be passed to the `:on_cancel` and `on_confirm` attributes
  for the caller to react to each button press, for example:

      <.modal id="confirm" on_confirm={JS.push("delete")} on_cancel={JS.navigate(~p"/posts")}>
        Are you sure you?
        <:confirm>OK</:confirm>
        <:cancel>Cancel</:cancel>
      </.modal>
  """
  attr :id, :string, required: true
  attr :show, :boolean, default: false
  attr :on_cancel, JS, default: %JS{}
  attr :on_confirm, JS, default: %JS{}

  slot :inner_block, required: true
  slot :title
  slot :subtitle
  slot :confirm
  slot :cancel

  def modal(assigns) do
    ~H"""
    <div
      id={@id}
      phx-mounted={@show && show_modal(@id)}
      phx-remove={hide_modal(@id)}
      class="relative z-50 hidden"
    >
      <div
        id={"#{@id}-bg"}
        class="fixed inset-0 bg-zinc-50/90 dark:bg-slate-900/90 transition-opacity"
        aria-hidden="true"
      />
      <div
        class="fixed inset-0 overflow-y-auto"
        aria-labelledby={"#{@id}-title"}
        aria-describedby={"#{@id}-description"}
        role="dialog"
        aria-modal="true"
        tabindex="0"
      >
        <div class="flex min-h-full items-center justify-center">
          <div class="w-full max-w-3xl p-4 sm:p-6 lg:py-8">
            <.focus_wrap
              id={"#{@id}-container"}
              phx-mounted={@show && show_modal(@id)}
              phx-window-keydown={hide_modal(@on_cancel, @id)}
              phx-key="escape"
              phx-click-away={hide_modal(@on_cancel, @id)}
              class="hidden relative rounded-2xl bg-white dark:bg-gray-800 p-6 shadow-lg shadow-zinc-700/10 ring-1 ring-zinc-700/10 transition"
            >
              <div class="absolute top-6 right-5">
                <button
                  phx-click={hide_modal(@on_cancel, @id)}
                  type="button"
                  class="-m-3 flex-none p-3 opacity-20 hover:opacity-40"
                  aria-label={gettext("close")}
                >
                  <Heroicons.x_mark solid class="h-5 w-5 stroke-current" />
                </button>
              </div>
              <div id={"#{@id}-content"}>
                <header :if={@title != []}>
                  <h1 id={"#{@id}-title"} class="text-xl text-slate-500 font-semibold leading-8">
                    <%= render_slot(@title) %>
                  </h1>
                  <p :if={@subtitle != []} id={"#{@id}-description"} class="mt-2 leading-6">
                    <%= render_slot(@subtitle) %>
                  </p>
                </header>
                <%= render_slot(@inner_block) %>
                <div :if={@confirm != [] or @cancel != []} class="ml-6 mb-4 flex items-center gap-5">
                  <.link
                    :for={cancel <- @cancel}
                    phx-click={hide_modal(@on_cancel, @id)}
                    class="text-sm font-semibold leading-6"
                  >
                    <%= render_slot(cancel) %>
                  </.link>
                </div>
              </div>
            </.focus_wrap>
          </div>
        </div>
      </div>
    </div>
    """
  end

  @doc """
  Renders a header with title.
  """
  attr :class, :string, default: nil

  slot :inner_block, required: true
  slot :subtitle
  slot :actions

  def header(assigns) do
    ~H"""
    <header class={[@actions != [] && "flex items-center justify-between gap-6", @class]}>
      <div>
        <h1 class="text-lg font-semibold leading-8">
          <%= render_slot(@inner_block) %>
        </h1>
        <p :if={@subtitle != []} class="mt-2 text-sm leading-6">
          <%= render_slot(@subtitle) %>
        </p>
      </div>
      <div class="flex-none"><%= render_slot(@actions) %></div>
    </header>
    """
  end

  @doc """
  generates search input
  """
  def search_input(assigns) do
    ~H"""
    <form action="" novalidate="" role="search" phx-change="search-filter">
      <div class="relative mt-10 h-9 w-full md:w-1/3 md:flex-shrink-0">
        <Heroicons.magnifying_glass solid class="inline-block absolute ml-2 text-gray-400 w-5 mt-1.5" />
        <input
          phx-debounce="500"
          phx-update="ignore"
          aria-autocomplete="both"
          autocomplete="off"
          autocorrect="off"
          autocapitalize="off"
          enterkeyhint="search school"
          spellcheck="false"
          type="search"
          name="search"
          id="search-input"
          class="border-gray-300 dark:border-slate-700 focus:border-gray-500 dark:focus:border-slate-500 appearance-none dark:shadow rounded-md focus:outline-none bg-white dark:bg-slate-900 h-8 w-full pl-10 focus:ring-0"
          placeholder="Search school"
          aria-label="Search"
        />
      </div>
    </form>
    """
  end

  attr :current_page, :integer, required: true
  attr :total_pages, :integer, required: true

  def table_paging(assigns) do
    ~H"""
    <div class="relative mt-10 flex justify-between items center">
      <div>
        <%= if @current_page > 1 do %>
          <button
            phx-click="previous-page"
            type="button"
            class="flex space-x-3 items-center btn-secondary"
          >
            <Heroicons.chevron_left solid class="w-4 h-4" />
            <span>previous</span>
          </button>
        <% end %>
      </div>
      <div>
        <%= if @current_page < @total_pages do %>
          <button
            phx-click="next-page"
            type="button"
            class="flex space-x-3 items-center btn-secondary"
          >
            <span>next</span>
            <Heroicons.chevron_right solid class="w-4 h-4" />
          </button>
        <% end %>
      </div>
    </div>
    """
  end

  @doc ~S"""
  Renders a table with generic styling.

  ## Examples

      <.table id="users" rows={@users}>
        <:col :let={user} label="id"><%= user.id %></:col>
        <:col :let={user} label="username"><%= user.username %></:col>
      </.table>
  """
  attr :id, :string, required: true
  attr :rows, :list, required: true
  attr :row_id, :any, default: nil, doc: "the function for generating the row id"
  attr :row_click, :any, default: nil, doc: "the function for handling phx-click on each row"

  attr :row_item, :any,
    default: &Function.identity/1,
    doc: "the function for mapping each row before calling the :col and :action slots"

  slot :col, required: true do
    attr :label, :string
  end

  slot :action, doc: "the slot for showing user actions in the last table column"

  def table(assigns) do
    assigns =
      with %{rows: %Phoenix.LiveView.LiveStream{}} <- assigns do
        assign(assigns, row_id: assigns.row_id || fn {id, _item} -> id end)
      end

    ~H"""
    <div class="overflow-hidden shadow md:rounded-lg mt-4">
      <div class="overflow-y-auto px-4 sm:overflow-visible sm:px-0">
        <table class="min-w-full divide-y divide-gray-300">
          <thead class="bg-gray-50 dark:bg-gray-800">
            <tr>
              <th :for={col <- @col}><%= col[:label] %></th>
              <th class="relative py-3.5 pl-3 pr-4 sm:pr-6 w-36">
                <span class="sr-only"><%= gettext("Actions") %></span>
              </th>
            </tr>
          </thead>
          <tbody id={@id} phx-update={match?(%Phoenix.LiveView.LiveStream{}, @rows) && "stream"}>
            <tr :for={row <- @rows} id={@row_id && @row_id.(row)} class="group">
              <td
                :for={{col, i} <- Enum.with_index(@col)}
                phx-click={@row_click && @row_click.(row)}
                class={["relative p-0", @row_click && "hover:cursor-pointer"]}
              >
                <div class="block px-6">
                  <span class="absolute -inset-y-px right-0 -left-4 sm:rounded-l-xl" />
                  <span class={["relative", i == 0 && "font-semibold"]}>
                    <%= render_slot(col, @row_item.(row)) %>
                  </span>
                </div>
              </td>
              <td :if={@action != []} class="relative pr-6 w-14">
                <div class="relative whitespace-nowrap text-right text-sm font-medium">
                  <span class="absolute -inset-y-px -right-4 left-0 sm:rounded-r-xl" />
                  <span :for={action <- @action} class="relative ml-4 font-semibold leading-6">
                    <%= render_slot(action, @row_item.(row)) %>
                  </span>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    """
  end

  @doc """
  Renders a data list.

  ## Examples

      <.list title="Title" items={@items} />
  """

  attr :title, :string, required: true
  attr :data, :map, required: true

  def list(assigns) do
    %{type: type, data: items} = assigns.data

    assigns =
      assigns
      |> assign(:type, type)
      |> assign(:items, items)

    ~H"""
    <div>
      <h2 class="font-semibold dark:text-slate-400"><%= @title %></h2>
      <ul role="list" class="mt-3 grid grid-cols-1 gap-5 sm:grid-cols-2 sm:gap-6 lg:grid-cols-3">
        <%= for item <- @items do %>
          <li class="col-span-1 flex rounded-md shadow-sm">
            <div class="flex flex-1 items-center justify-between truncate rounded-l-md border-b border-l border-t border-gray-200 dark:border-gray-600 bg-white dark:bg-gray-700">
              <div class="flex-1 flex space-x-2 items-center truncate px-4 py-2 h-12 overflow-hidden">
                <span class="font-medium"><%= item.label %><sup>th</sup></span> <span>score</span>
              </div>
            </div>
            <div class={"bg-gradient-to-r #{get_color(@type, item.score)} flex w-16 flex-shrink-0 items-center justify-center rounded-r-md text-lg font-bold text-white"}>
              <%= item.score %>
            </div>
          </li>
        <% end %>
      </ul>
    </div>
    """
  end

  ## JS Commands

  def show(js \\ %JS{}, selector) do
    JS.show(js,
      to: selector,
      transition:
        {"transition-all transform ease-out duration-300",
         "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95",
         "opacity-100 translate-y-0 sm:scale-100"}
    )
  end

  def hide(js \\ %JS{}, selector) do
    JS.hide(js,
      to: selector,
      time: 200,
      transition:
        {"transition-all transform ease-in duration-200",
         "opacity-100 translate-y-0 sm:scale-100",
         "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"}
    )
  end

  def show_modal(js \\ %JS{}, id) when is_binary(id) do
    js
    |> JS.show(to: "##{id}")
    |> JS.show(
      to: "##{id}-bg",
      transition: {"transition-all transform ease-out duration-300", "opacity-0", "opacity-100"}
    )
    |> show("##{id}-container")
    |> JS.add_class("overflow-hidden", to: "body")
    |> JS.focus_first(to: "##{id}-content")
  end

  def hide_modal(js \\ %JS{}, id) do
    js
    |> JS.hide(
      to: "##{id}-bg",
      transition: {"transition-all transform ease-in duration-200", "opacity-100", "opacity-0"}
    )
    |> hide("##{id}-container")
    |> JS.hide(to: "##{id}", transition: {"block", "block", "hidden"})
    |> JS.remove_class("overflow-hidden", to: "body")
    |> JS.pop_focus()
  end

  defp get_color(:lsat, score) when is_integer(score) do
    (score / 180 * 100)
    |> get_color_css()
  end

  defp get_color(:gpa, score) when is_float(score) do
    (score / 4 * 100)
    |> get_color_css()
  end

  defp get_color(:gre_v, score) when is_integer(score) do
    (score / 170 * 100)
    |> get_color_css()
  end

  defp get_color(:gre_q, score) when is_integer(score) do
    (score / 170 * 100)
    |> get_color_css()
  end

  defp get_color(:gre_w, score) when is_float(score) do
    (score / 6 * 100)
    |> get_color_css()
  end

  defp get_color(_, _), do: get_color_css(0)

  defp get_color_css(percentage) do
    cond do
      percentage >= 90 -> "from-green-600 to-emerald-600"
      percentage >= 85 -> "from-lime-500 to-lime-600"
      percentage >= 80 -> "from-blue-600 to-indigo-600"
      percentage >= 70 -> "from-violet-600 to-purple-600"
      percentage >= 60 -> "from-yellow-500 to-amber-500"
      percentage >= 50 -> "from-pink-600 to-rose-600"
      percentage >= 30 -> "from-red-600 to-red-700"
      true -> "bg-red-950"
    end
  end
end
