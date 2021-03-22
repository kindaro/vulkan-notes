---
header-includes: \usepackage{quiver}
mainfont: Alegreya
monofont: Alegreya Sans Italic
---

## What I find unlikeworthy.

### Description of a formal system in a natural language is inefficient.

- What is written as taking a longish structure and a pointer of some type is
  actually a function from the arguments packed into the structure to that
  type.
- The allocator argument may also be made implicit for clarity.
- Physical and logical devices may be passed as a read only state.

### A lot of magical speaking that does not explain anything.

- It is not explained what sort of relations are these:

  + Descriptor sets are bound to command buffers.
  + Push constants belong to ranges.

  Are they many to many?

- Why is the swap cycle called a swap chain? A chain is a total order — it may
  not cycle.

- Pipe line state is not a state. It is a configuration.

It looks as though the terminology has grown organically and has never been
rationally reflected upon.

### It is not explained at all what happens under the hood.

Why do I have to do all these tedious manipulations? What happens when I create
a logical device? When I bind a pipe line to a command buffer?

### Fragile duplication.

Examples:

- The following all take a pipeline bind point enumeration parameter:
  + Creation of a subpass.
  + Binding of a descriptor set to a command buffer.
  + Binding of a pipe line to a command buffer.

Should these parameters be in agreement? If so, why the same value is set in
three different places?

### I am supposed to use a colour format for vertex position data?

`VkFormat` is used to define vertex buffer layout, even though it is an image
format? What sense does it make to put coördinates into a type that is supposed
to reperesent colours?

## Vulkan in categorial diagrams.

### Line.

$$
% https://q.uiver.app/?q=WzAsMTAsWzEsMCwiVl8zIMOXIFxcdGV4dHtkZXNjcmlwdG9ycz99Il0sWzMsMCwiVl8zIl0sWzQsMCwiXFx0ZXh0e3RvcG9sb2d5fShWXzMpIl0sWzYsMCwiXFx0ZXh0e3ByaW1pdGl2ZX0iXSxbNywwLCJWXzIgw5cgXFx0ZXh0e2Rlc2NyaXB0b3JzP30iXSxbOSwwLCJcXHRleHR7Y29sb3VyfSJdLFsxLDIsIlxcYnVsbGV0Il0sWzksMiwiSU8gXFxEZWx0YV8xIl0sWzAsMiwiXFx0ZXh0e3ZlcnRleCBidWZmZXJ9Il0sWzAsMywiXFx0ZXh0e3VuaWZvcm0gYnVmZmVyfSJdLFswLDEsIlxcdGV4dHt2ZXJ0ZXggc2hhZGVyfSJdLFsyLDMsIlxcdGV4dHtnZW9tZXRyeSBzaGFkZXJ9Il0sWzQsNSwiXFx0ZXh0e3BpeGVsIHNoYWRlcn0iXSxbNiw3LCJcXHRleHR7cGlwZSBsaW5lfSJdLFs2LDgsIiIsMix7InN0eWxlIjp7ImJvZHkiOnsibmFtZSI6ImRvdHRlZCJ9fX1dLFs2LDksIiIsMix7InN0eWxlIjp7ImJvZHkiOnsibmFtZSI6ImRvdHRlZCJ9fX1dXQ==
\begin{tikzcd}
	& {V_3 × \text{descriptors?}} && {V_3} & {\text{topology}(V_3)} && {\text{primitive}} & {V_2 × \text{descriptors?}} && {\text{colour}} \\
	\\
	{\text{vertex buffer}} & \bullet &&&&&&&& {IO \Delta_1} \\
	{\text{uniform buffer}}
	\arrow["{\text{vertex shader}}", from=1-2, to=1-4]
	\arrow["{\text{geometry shader}}", from=1-5, to=1-7]
	\arrow["{\text{pixel shader}}", from=1-8, to=1-10]
	\arrow["{\text{pipe line}}", from=3-2, to=3-10]
	\arrow[dotted, from=3-2, to=3-1]
	\arrow[dotted, from=3-2, to=4-1]
\end{tikzcd}
$$

### Initialization.

$$
% https://q.uiver.app/?q=WzAsMTgsWzQsMiwiXFx0ZXh0e2NhcmR9Il0sWzQsMywiXFx7XFx0ZXh0e2ZhbWlseX1cXH0iXSxbMywwLCJcXHRleHR7aW5zdGFuY2V9Il0sWzQsMCwiXFx7XFx0ZXh0e2NhcmR9XFx9Il0sWzIsMSwiXFx0ZXh0e3N1cmZhY2V9Il0sWzEsMCwiXFx0ZXh0e3dpbmRvd30iXSxbMiwwLCJcXGJ1bGxldCJdLFsyLDIsIlxcYnVsbGV0Il0sWzAsMiwiXFx7XFx0ZXh0e2Zvcm1hdH1cXH0iXSxbMiw0LCJcXHRleHR7ZmFtaWx5fSJdLFswLDQsIlxcRGVsdGFfMiJdLFszLDQsIlxcYnVsbGV0Il0sWzMsNSwiXFx0ZXh0e2xvZ2ljfSJdLFsyLDMsIlxcYnVsbGV0Il0sWzAsMywiXFxEZWx0YV8yIl0sWzQsNCwiXFx7XFx0ZXh0e2ZhbWlseX0gw5cgXFxtYXRoYmJ7Tn1cXH0iXSxbMCwxLCJcXHtcXHRleHR7bW9kZX1cXH0iXSxbMCwwLCJcXHRleHR7Y2FwYWJpbGl0aWVzfSJdLFswLDFdLFsyLDNdLFs2LDUsIiIsMCx7InN0eWxlIjp7ImJvZHkiOnsibmFtZSI6ImRvdHRlZCJ9fX1dLFs2LDIsIiIsMSx7InN0eWxlIjp7ImJvZHkiOnsibmFtZSI6ImRvdHRlZCJ9fX1dLFs2LDRdLFs3LDAsIiIsMCx7InN0eWxlIjp7ImJvZHkiOnsibmFtZSI6ImRvdHRlZCJ9fX1dLFs3LDQsIiIsMCx7InN0eWxlIjp7ImJvZHkiOnsibmFtZSI6ImRvdHRlZCJ9fX1dLFs3LDhdLFsxMSwyLCIiLDIseyJzdHlsZSI6eyJib2R5Ijp7Im5hbWUiOiJkb3R0ZWQifX19XSxbMTEsMTJdLFsxMyw5LCIiLDIseyJzdHlsZSI6eyJib2R5Ijp7Im5hbWUiOiJkb3R0ZWQifX19XSxbMTMsMTQsIlxcdGV4dHtpcyBzdXJmYWNlIHN1cHBvcnRlZH0iLDJdLFs5LDEwLCJcXHRleHR7aGFzIGdyYXBoaWNzfSIsMl0sWzEzLDcsIiIsMCx7InN0eWxlIjp7ImJvZHkiOnsibmFtZSI6ImRvdHRlZCJ9fX1dLFsxMSwxNSwiIiwyLHsic3R5bGUiOnsiYm9keSI6eyJuYW1lIjoiZG90dGVkIn19fV0sWzcsMTZdLFs3LDE3XV0=
\begin{tikzcd}
	{\text{capabilities}} & {\text{window}} & \bullet & {\text{instance}} & {\{\text{card}\}} \\
	{\{\text{mode}\}} && {\text{surface}} \\
	{\{\text{format}\}} && \bullet && {\text{card}} \\
	{\Delta_2} && \bullet && {\{\text{family}\}} \\
	{\Delta_2} && {\text{family}} & \bullet & {\{\text{family} × \mathbb{N}\}} \\
	&&& {\text{logic}}
	\arrow[from=3-5, to=4-5]
	\arrow[from=1-4, to=1-5]
	\arrow[dotted, from=1-3, to=1-2]
	\arrow[dotted, from=1-3, to=1-4]
	\arrow[from=1-3, to=2-3]
	\arrow[dotted, from=3-3, to=3-5]
	\arrow[dotted, from=3-3, to=2-3]
	\arrow[from=3-3, to=3-1]
	\arrow[dotted, from=5-4, to=1-4]
	\arrow[from=5-4, to=6-4]
	\arrow[dotted, from=4-3, to=5-3]
	\arrow["{\text{is surface supported}}"', from=4-3, to=4-1]
	\arrow["{\text{has graphics}}"', from=5-3, to=5-1]
	\arrow[dotted, from=4-3, to=3-3]
	\arrow[dotted, from=5-4, to=5-5]
	\arrow[from=3-3, to=2-1]
	\arrow[from=3-3, to=1-1]
\end{tikzcd}
$$

### Execution _(reading logical device)_.

$$
% https://q.uiver.app/?q=WzAsNSxbMywxLCJcXG1hdGhybXtJT30gXFxEZWx0YV8xIl0sWzEsMSwiXFxidWxsZXQiXSxbMSwwLCJcXHRleHR7cXVldWV9Il0sWzAsMSwiXFx0ZXh0e2NvbW1hbmQgYnVmZmVyfSJdLFszLDAsIlxcbWF0aHJte0lPfSBcXERlbHRhXzEiXSxbMSwwLCJcXHRleHR7c3VibWl0fSJdLFsxLDIsIiIsMix7InN0eWxlIjp7ImJvZHkiOnsibmFtZSI6ImRvdHRlZCJ9fX1dLFsxLDMsIiIsMCx7InN0eWxlIjp7ImJvZHkiOnsibmFtZSI6ImRvdHRlZCJ9fX1dLFsyLDQsIlxcdGV4dHtwcmVzZW50fSJdXQ==
\begin{tikzcd}
	& {\text{queue}} && {\mathrm{IO} \Delta_1} \\
	{\text{command buffer}} & \bullet && {\mathrm{IO} \Delta_1}
	\arrow["{\text{submit}}", from=2-2, to=2-4]
	\arrow[dotted, from=2-2, to=1-2]
	\arrow[dotted, from=2-2, to=2-1]
	\arrow["{\text{present}}", from=1-2, to=1-4]
\end{tikzcd}
$$

### Queue and command buffer _(reading logical device)_.

$$
% https://q.uiver.app/?q=WzAsNCxbMCwwLCJcXHRleHR7ZmFtaWx5fSJdLFsxLDAsIlxcdGV4dHtxdWV1ZX0iXSxbMCwxLCJcXHRleHR7Y29tbWFuZCBwb29sfSJdLFsxLDEsIlxcdGV4dHtjb21tYW5kIGJ1ZmZlcn0iXSxbMCwxXSxbMCwyXSxbMiwzXV0=
\begin{tikzcd}
	{\text{family}} & {\text{queue}} \\
	{\text{command pool}} & {\text{command buffer}}
	\arrow[from=1-1, to=1-2]
	\arrow[from=1-1, to=2-1]
	\arrow[from=2-1, to=2-2]
\end{tikzcd}
$$

### Pass and frame buffer _(reading logical device)_.

$$
% https://q.uiver.app/?q=WzAsMTgsWzAsMiwiXFx0ZXh0e21vZGV9Il0sWzEsMiwiXFxidWxsZXQiXSxbMiwyLCJcXHRleHR7c3dhcCBjeWNsZX0iXSxbMCwzLCJcXHRleHR7Zm9ybWF0fSJdLFszLDUsIlxcdGV4dHtwYXNzfSJdLFswLDEsIlxcdGV4dHtjYXBhYmlsaXRpZXN9Il0sWzAsMCwiXFx0ZXh0e3N1cmZhY2V9Il0sWzQsMywiXFxidWxsZXQiXSxbMywyLCJcXHtcXHRleHR7aW1hZ2V9XFx9Il0sWzQsNCwiXFx0ZXh0e3ZpZXd9Il0sWzQsMiwiXFx0ZXh0e2ltYWdlfSJdLFs0LDUsIlxcYnVsbGV0Il0sWzAsNSwiXFx0ZXh0e2F0dGFjaG1lbnR9Il0sWzEsNiwiXFx0ZXh0e3N1YnBhc3N9Il0sWzIsNiwiXFx7XFx0ZXh0e3N1YnBhc3N9XFx9Il0sWzIsNSwiXFxidWxsZXQiXSxbMSw1LCJcXHtcXHRleHR7YXR0YWNobWVudH1cXH0iXSxbNSw1LCJcXHRleHR7ZnJhbWUgYnVmZmVyfSJdLFsxLDAsIiIsMix7InN0eWxlIjp7ImJvZHkiOnsibmFtZSI6ImRvdHRlZCJ9fX1dLFsxLDJdLFsxLDMsIiIsMix7InN0eWxlIjp7ImJvZHkiOnsibmFtZSI6ImRvdHRlZCJ9fX1dLFsxLDUsIiIsMCx7InN0eWxlIjp7ImJvZHkiOnsibmFtZSI6ImRvdHRlZCJ9fX1dLFsxLDYsIiIsMix7InN0eWxlIjp7ImJvZHkiOnsibmFtZSI6ImRvdHRlZCJ9fX1dLFs3LDMsIiIsMix7InN0eWxlIjp7ImJvZHkiOnsibmFtZSI6ImRvdHRlZCJ9fX1dLFsyLDhdLFs3LDldLFs3LDEwLCIiLDAseyJzdHlsZSI6eyJib2R5Ijp7Im5hbWUiOiJkb3R0ZWQifX19XSxbMTEsNCwiIiwwLHsic3R5bGUiOnsiYm9keSI6eyJuYW1lIjoiZG90dGVkIn19fV0sWzExLDksIiIsMix7InN0eWxlIjp7ImJvZHkiOnsibmFtZSI6ImRvdHRlZCJ9fX1dLFszLDEyXSxbMTUsMTQsIiIsMix7InN0eWxlIjp7ImJvZHkiOnsibmFtZSI6ImRvdHRlZCJ9fX1dLFsxNSwxNiwiIiwyLHsic3R5bGUiOnsiYm9keSI6eyJuYW1lIjoiZG90dGVkIn19fV0sWzE1LDRdLFsxMSwxN10sWzE2LDEzXV0=
\begin{tikzcd}
	{\text{surface}} \\
	{\text{capabilities}} \\
	{\text{mode}} & \bullet & {\text{swap cycle}} & {\{\text{image}\}} & {\text{image}} \\
	{\text{format}} &&&& \bullet \\
	&&&& {\text{view}} \\
	{\text{attachment}} & {\{\text{attachment}\}} & \bullet & {\text{pass}} & \bullet & {\text{frame buffer}} \\
	& {\text{subpass}} & {\{\text{subpass}\}}
	\arrow[dotted, from=3-2, to=3-1]
	\arrow[from=3-2, to=3-3]
	\arrow[dotted, from=3-2, to=4-1]
	\arrow[dotted, from=3-2, to=2-1]
	\arrow[dotted, from=3-2, to=1-1]
	\arrow[dotted, from=4-5, to=4-1]
	\arrow[from=3-3, to=3-4]
	\arrow[from=4-5, to=5-5]
	\arrow[dotted, from=4-5, to=3-5]
	\arrow[dotted, from=6-5, to=6-4]
	\arrow[dotted, from=6-5, to=5-5]
	\arrow[from=4-1, to=6-1]
	\arrow[dotted, from=6-3, to=7-3]
	\arrow[dotted, from=6-3, to=6-2]
	\arrow[from=6-3, to=6-4]
	\arrow[from=6-5, to=6-6]
	\arrow[from=6-2, to=7-2]
\end{tikzcd}
$$
