# Lab 11 - Counters and Dividers

In this lab, we learned how to make clock dividers from two types of counters.

## Rubric

| Item | Description | Value |
| ---- | ----------- | ----- |
| Summary Answers | Your writings about what you learned in this lab. | 25% |
| Question 1 | Your answers to the question | 25% |
| Question 2 | Your answers to the question | 25% |
| Question 3 | Your answers to the question | 25% |

## Lab Questions

### 1 - Why does the Modulo Counter actually divide clocks by 2 * Count?
Each Hz is defined as a cycle going from down to up, and up to down. This makes the clocks divide by 2 instead of 1.
### 2 - Why does the ring counter's output go to all 1s on the first clock cycle?
T is hardwired to one because at the first clock cycle, all the T-Flip Flops go high (1).
### 3 - What width of ring counter would you use to get to an output of ~1KHz?
KHz = 10^3 = 1000. 1000 in binary = 1111101000 = 10 digits = width of 10.
