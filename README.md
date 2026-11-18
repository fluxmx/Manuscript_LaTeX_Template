# My Paper Template

A minimal LaTeX template for English research papers, combining restrained journal typography with familiar conference-paper conventions. It is inspired by Nature and Science, but is not an official submission template for either journal.

The layout uses black text, Times-style fonts, and blue citations and hyperlinks. It has no logos, project branding, coloured heading blocks, or main-text table of contents. Email addresses are black and monospaced.

Repository: [fluxmx/My_Paper_Template](https://github.com/fluxmx/My_Paper_Template).

## Requirements and compilation

Use a TeX Live or MiKTeX installation containing pdfLaTeX, BibTeX, and the packages loaded by `simple.sty`. The template uses the standard `article` class with `newtxtext` and `newtxmath`.

These are **Times-style fonts, not Times New Roman**. No system fonts, XeLaTeX, Python, shell escape, or runtime downloads are required when the TeX dependencies are installed.

Compile from the repository root:

```sh
latexmk -pdf main.tex
```

Alternatively, use the standard compilation sequence:

```sh
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex
```

The PDF and auxiliary files are written beside `main.tex`. Optional Make targets are:

```sh
make        # Build main.pdf using the selected layout
make clean  # Clean auxiliary files while preserving the PDF
```

## Single-column and two-column layouts

Select the layout when loading the style in `main.tex`. Use one of these lines:

```latex
\usepackage[singlecolumn]{simple} % Single-column article (default)
\usepackage[twocolumn]{simple}    % Two-column body; full-width title and abstract
```

Without options, `\usepackage{simple}` defaults to a single column. `onecolumn` is an alias for `singlecolumn`.

Both layouts use the same `main.tex` and content files. Keep the standard `\maketitle` followed by the `abstract` environment; the style arranges the full-width opening automatically. There is no need to insert `\twocolumn` manually or maintain a second main file.

## Files to edit

| File | Purpose |
| --- | --- |
| `main.tex` | Main entry point and layout option |
| `metadata.tex` | Title, authors, affiliations, contribution notes, and email |
| `frontmatter.tex` | Standard title and abstract commands |
| `sections/abstract.tex` | Abstract text |
| `sections/body.tex` | Main text, figures, tables, and equations |
| `references.bib` | BibTeX references |
| `content.tex` | Main-text, bibliography, and optional appendix inclusion |
| `sections/supplement.tex` | Supplementary methods and derivations |
| `simple.sty` | Shared typography and layout settings |

Use ordinary LaTeX commands such as `\section`, `\subsection`, `\cite`, `\label`, `\ref`, and `\eqref`. The example prose is a writing guide, not a scientific report. The sample bibliography entry demonstrates citation formatting and does not support the placeholder prose.

### Title and authors

Enter the title as continuous text with normal spaces:

```latex
\title{Your paper title}
```

Avoid manual line breaks (`\\`) or nonbreaking spaces inside the title. It uses the full available width, aligns left, and wraps naturally without forcing balanced line lengths. Actual arXiv HTML conversion should still be checked during submission.

Use standard `\author`, `\textsuperscript`, and `\\` commands for the author and affiliation block. Enter each email address only once:

```latex
\email{author@university.edu}
```

This creates a clickable `mailto:` link while keeping the displayed address black and monospaced.

### Sections, figures, and tables

Main-text headings are unnumbered by default. Citations use superscript numbers; figures, tables, and equations remain numbered. If numbered main-text headings are needed, add this after loading the style:

```latex
\setcounter{secnumdepth}{2}
\titleformat{\section}{\large\bfseries}{\thesection}{0.6em}{}
\titleformat{\subsection}{\normalsize\bfseries}{\thesubsection}{0.6em}{}
```

Do not use `\ref` to obtain a section number while headings are unnumbered.

Include figures with `\includegraphics[width=\linewidth]{...}`. In two-column mode, use standard `figure*` and `table*` environments for full-width displays. Use PDF, PNG, or JPG graphics with pdfLaTeX.

The title and abstract form a full-width opening in two-column mode. For exceptionally long author lists or abstracts, use the single-column layout.

## Appendix

The appendix is disabled by default. Enable it by uncommenting these lines at the end of `content.tex`:

```latex
\appendix
\input{sections/supplement}
```

The appendix starts on a new page with the paper title, followed by “Supplementary information” and an appendix-only table of contents. This opening page is always single-column. Appendix text starts on the next page and returns to the article's selected column layout.

Appendix sections use letters, such as Appendix A and Appendix B; subsections use A.1 and A.2. Page, figure, table, and equation numbers continue from the main article. The main text has no table of contents.

The contents are generated with `titletoc`; `latexmk` repeats compilation as needed to update entries, page numbers, and links.

## Hyperlinks

The style defines pure blue links using RGB `0, 0, 255` (`#0000FF`):

```latex
\definecolor{LinkBlue}{RGB}{0,0,255}
\hypersetup{
  colorlinks=true,
  allcolors=LinkBlue
}
% \hypersetup{hidelinks}
```

This applies to citations, cross-references, URLs, and appendix contents links. Email text remains black.

Uncomment `\hypersetup{hidelinks}` in `simple.sty` to remove link colours and borders while retaining clickable links. You can also place that command after `\usepackage{simple}` in the main file.

## Submission and arXiv

Upload `main.tex`, all included `.tex` files, `simple.sty`, `references.bib`, and the figures actually used. Include the corresponding `.bbl` file when required; it is generated beside the main file. Keep only the intended main entry in the submission package to avoid ambiguous automatic compilation.

The template uses standard TeX-distribution packages to reduce dependencies, but local compilation does not guarantee acceptance by every submission platform. If a publisher requires its official class or template, migrate the article content to that template.

Check the current platform instructions before submitting:

- [TeX Live and supported processors at arXiv](https://info.arxiv.org/help/faq/texlive.html)
- [Submitting TeX/LaTeX to arXiv](https://info.arxiv.org/help/submit_tex.html)
- [The newtx font package](https://ctan.org/pkg/newtx)

## Version control and licensing

Generated PDFs, compilation files, and `output/` are ignored by Git. The `figures/` directory is also ignored; back up paper-specific graphics separately and include required graphics in submission packages.

See [LICENSE](LICENSE) for the project's terms and [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) for external dependency notices.
