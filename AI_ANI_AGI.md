# Artificial Intelligence (AI), Artificial Narrow Intelligence (ANI), and Artificial General Intelligence (AGI)

## 1. Artificial Intelligence (AI)

### Definition

Artificial Intelligence (AI) refers to the simulation of human intelligence in machines, enabling them to perform tasks typically requiring human cognitive abilities such as learning, reasoning, perception, and natural language understanding.

### Resources for AI

- [Stanford Artificial Intelligence Course (CS221)](http://cs221.stanford.edu/)
- [MIT Introduction to Deep Learning (6.S191)](http://introtodeeplearning.com/)
- [Artificial Intelligence – Wikipedia](https://en.wikipedia.org/wiki/Artificial_intelligence)

### Example of AI in Action

**Chatbots and Virtual Assistants** (e.g., Siri, Alexa, Google Assistant)

**Python Example Using OpenAI's GPT Model:**

```python
from openai import OpenAI

client = OpenAI(api_key="your_api_key_here")

response = client.chat.completions.create(
    model="gpt-4",
    messages=[{"role": "user", "content": "What is AI?"}]
)

print(response.choices[0].message['content'])
```

**Explanation:**

- Uses OpenAI’s GPT-4 API to generate natural language responses.
- Demonstrates natural language understanding and generation capabilities.

---

## 2. Artificial Narrow Intelligence (ANI)

### Definition

Artificial Narrow Intelligence (ANI), also known as Weak AI, describes AI systems specifically designed to perform defined tasks within limited domains, without possessing the ability to generalize beyond their trained scope.

### Resources for ANI

- [OpenAI’s GPT-4](https://openai.com/research/gpt-4)
- [Deep Learning by Ian Goodfellow](https://www.deeplearningbook.org/)
- [Google Machine Learning Crash Course](https://developers.google.com/machine-learning/crash-course)

### Example of ANI in Action

**Spam Filtering Systems (e.g., Gmail)**

**Python Example Using Scikit-Learn:**

```python
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.naive_bayes import MultinomialNB

# Emails dataset
emails = [
    "Win a free iPhone now!",  # Spam
    "Meeting scheduled for Monday at 10 AM",  # Not Spam
    "Congratulations! You have won a lottery",  # Spam
    "Please review the attached project report"  # Not Spam
]

labels = [1, 0, 1, 0]  # 1 = Spam, 0 = Not Spam

# Text to numeric features
vectorizer = CountVectorizer()
X = vectorizer.fit_transform(emails)

# Train a Naïve Bayes classifier
model = MultinomialNB()
model.fit(X, labels)

# Classify new email
test_email = ["Claim your free vacation package!"]
X_test = vectorizer.transform(test_email)

prediction = "Spam" if model.predict(X_test)[0] else "Not Spam"
print(prediction)
```

**Explanation:**

- The classifier learns to distinguish spam based on training examples.
- Specific to spam detection task only (ANI).

---

## 3. Artificial General Intelligence (AGI)

### Definition

Artificial General Intelligence (AGI), or Strong AI, refers to hypothetical AI systems capable of achieving human-level intelligence, performing any intellectual task across diverse domains, adapting, reasoning, and transferring knowledge from one context to another.

### Current Status

AGI does not currently exist; it remains a goal in AI research, requiring breakthroughs in understanding, reasoning, adaptability, and cognitive architectures.

### Resources for AGI

- [OpenAI’s Research on AGI](https://openai.com/research/)
- [DeepMind’s Research](https://deepmind.com/research/highlighted-research)
- [Ray Kurzweil’s Predictions](https://www.kurzweilai.net/)

### Example of AGI (Hypothetical Scenario)

**General-purpose AI assistant capable of learning arbitrary human tasks**

**Hypothetical Python Example:**

```python
class AGI:
    def learn(self, task):
        print(f"Learning task: {task}")

    def perform(self, task):
        print(f"Performing task: {task} at human-level proficiency.")

# Simulated AGI actions
ai = AGI()
ai.learn("playing chess")
ai.perform("playing chess")
ai.learn("composing music")
ai.perform("composing music")
```

**Explanation:**

- Hypothetical example illustrating how an AGI system could flexibly learn and adapt to new tasks beyond its initial programming.

---

## Conclusion and Comparison

| Category | Definition | Example | Real-world Implementations |
|----------|------------|---------|----------------------------|
| AI       | Machines simulating human cognitive tasks | Virtual assistants | Siri, Alexa, Google Assistant |
| ANI      | Specialized AI for single-domain tasks | Spam filters | Gmail spam filter, Tesla autopilot |
| AGI      | Hypothetical human-level intelligence across multiple domains | General-purpose AI assistant (hypothetical) | Future research goal |

Currently, ANI systems are prevalent, whereas AGI remains theoretical and actively researched.

---

## References

1. Russell, S., & Norvig, P. (2021). [*Artificial Intelligence: A Modern Approach (4th ed.)*](https://aima.cs.berkeley.edu/). Pearson Education.

2. Goodfellow, I., Bengio, Y., & Courville, A. (2016). [*Deep Learning*](https://www.deeplearningbook.org/). MIT Press.

3. [OpenAI Research](https://openai.com/research/)

4. [DeepMind Research](https://deepmind.com/research/highlighted-research)

5. Kurzweil, R. (2005). [*The Singularity Is Near: When Humans Transcend Biology*](https://www.kurzweilai.net/). Penguin Books.
