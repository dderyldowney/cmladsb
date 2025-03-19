# AI, ANI, and AGI: A Comparison

## Artificial Intelligence (AI)

The simulation of human intelligence in machines.

### Example: AI-Language Model

```python
from openai import OpenAI

client = OpenAI(api_key="your_api_key_here")
response = client.chat.completions.create(
    model="gpt-4",
    messages=[{"role": "user", "content": "What is AI?"}]
)
print(response.choices[0].message['content'])
```

## Artificial Narrow Intelligence (ANI)

AI systems designed for specific tasks within limited domains.

### Example: Spam Filter

```python
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.naive_bayes import MultinomialNB

emails = ["Win free iPhone!", "Meeting at 10 AM"]
labels = [1, 0]  # 1 = Spam, 0 = Not Spam

vectorizer = CountVectorizer()
X = vectorizer.fit_transform(emails)
model = MultinomialNB()
model.fit(X, labels)
```

## Artificial General Intelligence (AGI)

Hypothetical AI capable of human-level intelligence across all domains.

### Example: Conceptual Model

```python
class AGI:
    def learn(self, task): print(f"Learning: {task}")
    def perform(self, task): print(f"Performing: {task}")
```

## Comparison

| Type | Purpose | Status |
|------|---------|---------|
| AI   | Simulate intelligence | Active |
| ANI  | Single-domain tasks | Widespread |
| AGI  | General intelligence | Theoretical |

## References

1. Russell, S., & Norvig, P. (2021). *Artificial Intelligence: A Modern Approach*
2. OpenAI Research: [openai.com/research](https://openai.com/research/)
