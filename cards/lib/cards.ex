defmodule Cards do
  @moduledoc """
  Documentation for `Cards`.
  """

  @doc """
  Creates a deck of cards.
  """
  def create_deck do
    values = [
      "Ace",
      "Two",
      "Three",
      "Four",
      "Five",
      "Six",
      "Seven",
      "Eight",
      "Nine",
      "Ten",
      "Jack",
      "Queen",
      "King"
    ]

    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
  Shuffles a deck of cards.
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Checks if a deck of cards contains a specific card.

  ## Examples

      iex> Cards.contains?(["Ace of Spades"], "Ace of Spades")
      true

      iex> Cards.contains?(["Ace of Spades"], "Ace of Clubs")
      false
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Deals a hand of cards from a deck.

  ## Examples
      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
  Saves a deck of cards to a file.
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
  Loads a deck of cards from a file.
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _} -> []
    end
  end

  @doc """
  Creates a hand of cards.
  """
  def create_hand(hand_size) do
    create_deck()
    |> shuffle
    |> deal(hand_size)
  end
end
