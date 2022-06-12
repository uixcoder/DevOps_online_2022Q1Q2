def main():
    sentence = input("Input a Sentence: ")
    print(sentence)
    sentence = convert(sentence)
    print(sentence)


def convert(sentence):
    words = sentence.split(" ")
    emojis = {
        ":)": "😀",
        ":(": "😞",
        "lol": "😂",
        "sick": "😨",
        "happy": "😀"
    }
    outcome = " "
    for word in words:
        outcome += emojis.get(word, word) + " "
    return outcome


main()
