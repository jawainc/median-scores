defmodule SchoolWeb.MedianLive.ShowComponent do
  use SchoolWeb, :live_component

  def render(assigns) do
    ~H"""
    <div>
      <div class="mt-2">
        Year:
        <span class="font-semibold mr-10 dark:text-slate-200"><%= @school.first_year_class %></span>
        Rank:
        <span class={"inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-medium text-white #{rank_color(@school.rank)}"}>
          <%= @school.rank %>
        </span>
      </div>

      <div class="overflow-hidden flex flex-col space-y-16 mt-5 pt-5">
        <.list title="LSAT Median Scores" data={@lsat_scores} />
        <.list title="GPA Median Scores" data={@gpa_scores} />
        <.list :if={!@gre_v_scores.is_empty} title="GRE Verbal Median Scores" data={@gre_v_scores} />
        <.list :if={!@gre_q_scores.is_empty} title="GRE Quantitative Median Scores" data={@gre_q_scores} />
        <.list :if={!@gre_w_scores.is_empty} title="GRE Writing Median Scores" data={@gre_w_scores} />
      </div>
    </div>
    """
  end

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> get_lsat_scores()
     |> get_gpa_scores()
     |> get_gre_v_scores()
     |> get_gre_q_scores()
     |> get_gre_w_scores()}
  end

  defp get_lsat_scores(socket) do
    school = socket.assigns.school

    socket
    |> assign(:lsat_scores, %{
      type: :lsat,
      data: [
        %{label: "75", score: school.l75},
        %{label: "50", score: school.l50},
        %{label: "25", score: school.l25}
      ]
    })
  end

  defp get_gpa_scores(socket) do
    school = socket.assigns.school

    socket
    |> assign(:gpa_scores, %{
      type: :gpa,
      data: [
        %{label: "75", score: school.g75},
        %{label: "50", score: school.g50},
        %{label: "25", score: school.g25}
      ]
    })
  end

  defp get_gre_v_scores(socket) do
    school = socket.assigns.school

    socket
    |> assign(:gre_v_scores, %{
      is_empty: is_nil(school.gre75v),
      type: :gre_v,
      data: [
        %{label: "75", score: school.gre75v},
        %{label: "50", score: school.gre50v},
        %{label: "25", score: school.gre25v}
      ]
    })
  end

  defp get_gre_q_scores(socket) do
    school = socket.assigns.school

    socket
    |> assign(:gre_q_scores, %{
      is_empty: is_nil(school.gre75q),
      type: :gre_q,
      data: [
        %{label: "75", score: school.gre75q},
        %{label: "50", score: school.gre50q},
        %{label: "25", score: school.gre25q}
      ]
    })
  end

  defp get_gre_w_scores(socket) do
    school = socket.assigns.school

    socket
    |> assign(:gre_w_scores, %{
      is_empty: is_nil(school.gre75w),
      type: :gre_w,
      data: [
        %{label: "75", score: school.gre75w},
        %{label: "50", score: school.gre50w},
        %{label: "25", score: school.gre25w}
      ]
    })
  end

  defp rank_color(rank) do
    rank =
      rank
      |> Integer.parse()
      |> parse_rank()

    cond do
      rank == :error -> "bg-red-900"
      rank <= 10 -> "bg-green-900"
      rank <= 20 -> "bg-green-600"
      rank <= 40 -> "bg-teal-700"
      rank <= 60 -> "bg-blue-700"
      rank <= 70 -> "bg-violet-700"
      rank <= 90 -> "bg-pink-700"
      true -> "bg-red-700"
    end
  end

  defp parse_rank(:error), do: :error
  defp parse_rank({num, _}), do: num
end
