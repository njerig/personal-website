---
title: How to Solve *Any* Quadratic Equation by Factoring
subtitle: Yes, you read that correctly.
tags: mathematics
---

## Two dilemmas

It felt like a typical day of mathematics tutoring. It turned out to be anything but.

A student who I used to work with regularly came in with algebra homework. He was learning about factoring and the quadratic formula. When he asked how I knew when we could factor a quadratic equation $$ax^2 + bx + c = 0, a \neq 0$$, there were two cases that were apparent to me:

1. $$a=1$$
2. $$a \neq 1$$

The first case was easiest. I taught him that, when $$a=1$$ (i.e. $$x^2 + bx + c = 0$$), you want two numbers with

$$
\left\{ 
\begin{array}{c}
\text{their sum} = -b \\ 
\text{their product} = c
\end{array}
\right. 
$$

(The second case was not much harder; I told him to just divide the whole equation by $$a$$ and he'll end up in a situation similar to the first case.)

This allows us to factor the quadratic expression into the form:

$$(x - \underline{\hspace{1em}})(x - \underline{\hspace{1em}})$$

However, there was something not immediately obvious to me (without using the guess-and-check method for factoring most of us learned in school): **how do we mathematically determine which two numbers solve the system?**

The student was also overwhelmed by the idea of having to remember the quadratic formula for the cases where the quadratic expression "cannot be factored cleanly".

While I told him something placating that day, deep down, I didn't really know what to tell him. I left work that day deeply dissatisfied with the guess-and-check method and the quadratic formula – never having questioned either before.

## Enter Po-Shen Loh

After digging around on YouTube for alternative methods of solving quadratic equations, I found a video by Po-Shen Loh, Carnegie Mellon mathematics professor and former coach of the US International Mathematics Olympiad team.

<iframe width="560" height="315" src="https://www.youtube.com/embed/XKBX0r3J-9Y" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

It's ~40 minutes long, so here I go over solving a general quadratic equation using the method he goes over in the video.

## Solving the general case (and recovering something familiar along the way)

Let's solve

$$ax^2 + bx + c = 0, a \neq 0$$

First, we divide everything by $$a$$ (so that we can use the sum-product method I described above). We get

$$x^2 + \frac{b}{a}x + \frac{c}{a} = 0$$

If we can find two numbers with

$$
\left\{ 
\begin{array}{c}
\text{their sum} = -\frac{b}{a} \\ 
\text{their product} = \frac{c}{a}
\end{array}
\right. 
$$

we can factor the left-hand side of the equation like so:

$$(x - \underline{\hspace{1em}})(x - \underline{\hspace{1em}}) = 0$$

and the two numbers which fill in the blanks will be the solutions of the equation.

Now, the two key ideas in Po-Shen Loh's video are:
1. The sum of two numbers is twice their average. 
2. The two aforementioned numbers must be an equal distance $$u$$ away from their average. 

Two numbers which add up to $$-\frac{b}{a}$$ are $$-\frac{b}{2a} + u$$ and $$-\frac{b}{2a} - u$$. So, we need a $$u$$ such that

$$(-\frac{b}{2a} + u)(-\frac{b}{2a} - u) = \frac{c}{a}$$

Now we solve for $$u$$.[^1]

$$
\begin{align*}
    \frac{b^2}{4a^2} - u^2 &= \frac{c}{a} \\
    \frac{b^2}{4a^2} - \frac{c}{a} &= u^2 \\
    \frac{b^2}{4a^2} - \frac{4ac}{4a^2} &= u^2 \\
    \frac{b^2-4ac}{4a^2} &= u^2 \\
    u &= \sqrt{\frac{b^2-4ac}{4a^2}} \\
    u &= \frac{\sqrt{b^2-4ac}}{2a}
\end{align*}
$$

We can substitute our expression for $$u$$ back into the expressions for the two numbers we found for the sum:

$$
\begin{align*}
    -\frac{b}{2a} + u &= -\frac{b}{2a} + \frac{\sqrt{b^2-4ac}}{2a} \\
    &= \boxed{\frac{-b+\sqrt{b^2-4ac}}{2a}}
\end{align*}
$$

and 

$$
\begin{align*}
    -\frac{b}{2a} - u &= -\frac{b}{2a} - \frac{\sqrt{b^2-4ac}}{2a} \\
    &= \boxed{\frac{-b-\sqrt{b^2-4ac}}{2a}}
\end{align*}
$$

These are the two solutions of $$ax^2 + bx + c = 0, a \neq 0$$. So,

$$\boxed{x = \frac{-b\pm\sqrt{b^2-4ac}}{2a}}$$

We recovered our ~~foe~~ friend, the quadratic formula!

## Back to tutoring
Sadly, the next time I saw the same student, he seemed ready to move on to the new topics he was learning in school that week.

I, however, remain amazed.

[^1]: Using the negative solution for $$u$$ yields the same results. Try it yourself (or watch the video)!
