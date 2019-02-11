# async agnoster.zsh-theme

`zplug "tholinka/agnoster-zsh-theme", as:theme`

# async information

This verison has been extended to allow loading some prompt segments asynchronously, see below on customizing your prompt view for info.

# Libs

* [zsh-async](https://github.com/mafredri/zsh-async), to allow async prompt building

# Compatibility

**NOTE:** In all likelihood, you will need to install a [Powerline-patched font](https://github.com/Lokaltog/powerline-fonts) for this theme to render correctly.

To test if your terminal and font support it, check that all the necessary characters are supported by copying the following command to your terminal: `echo "\ue0b0 \u00b1 \ue0a0 \u27a6 \u2718 \u26a1 \u2699"`. The result should look like this:

![Character Example](https://gist.githubusercontent.com/agnoster/3712874/raw/characters.png)

## What does it show?

- If the previous command failed (✘)
- User @ Hostname (if user is not DEFAULT_USER, which can then be set in your profile)
- Git status
  - Branch () or detached head (➦)
  - Current branch / SHA1 in detached head state
  - Dirty working directory (±, color change)
- Working directory
- Elevated (root) privileges (⚡)

![Screenshot](https://gist.githubusercontent.com/agnoster/3712874/raw/screenshot.png)

## Customize your prompt view

By default prompt has these segments: `prompt_status`, `prompt_context`, `prompt_virtualenv`, `prompt_dir`, `prompt_git`, `prompt_end` in that particular order.

If you want to add, change the order or remove some segments of the prompt, you can use array environment variable named `AGNOSTER_PROMPT_SEGMENTS`.

This version has been extended to allow asynchronous prompt building, based off of [alien](https://github.com/eendroroy/alien), use `AGNOSTER_PROMPT_ASYNC_SEGMENTS` to define which segments should be included only after the prompt loads.  By default `prompt_virtualenv` and `prompt_git` are loaded asynchronously.

This considerably speeds up getting a basic prompt, with the downside being that the async information pops in a few moments later.

Examples:
- Show all segments of the prompt with indices:
```
echo "${(F)AGNOSTER_PROMPT_SEGMENTS[@]}" | cat -n
```
- Add the new segment of the prompt to the beginning:
```
AGNOSTER_PROMPT_SEGMENTS=("prompt_git" "${AGNOSTER_PROMPT_SEGMENTS[@]}")
```
- Add the new segment of the prompt to the end:
```
AGNOSTER_PROMPT_SEGMENTS+="prompt_end"
```
- Insert the new segment of the prompt = `PROMPT_SEGMENT_NAME` on the particular position = `PROMPT_SEGMENT_POSITION`:
```
PROMPT_SEGMENT_POSITION=5 PROMPT_SEGMENT_NAME="prompt_end";\
AGNOSTER_PROMPT_SEGMENTS=("${AGNOSTER_PROMPT_SEGMENTS[@]:0:$PROMPT_SEGMENT_POSITION-1}" "$PROMPT_SEGMENT_NAME" "${AGNOSTER_PROMPT_SEGMENTS[@]:$PROMPT_SEGMENT_POSITION-1}");\
unset PROMPT_SEGMENT_POSITION PROMPT_SEGMENT_NAME
```
- Swap segments 4th and 5th:
```
SWAP_SEGMENTS=(4 5);\
TMP_VAR="$AGNOSTER_PROMPT_SEGMENTS[$SWAP_SEGMENTS[1]]"; AGNOSTER_PROMPT_SEGMENTS[$SWAP_SEGMENTS[1]]="$AGNOSTER_PROMPT_SEGMENTS[$SWAP_SEGMENTS[2]]"; AGNOSTER_PROMPT_SEGMENTS[$SWAP_SEGMENTS[2]]="$TMP_VAR"
unset SWAP_SEGMENTS TMP_VAR
```
- Remove the 5th segment:
```
AGNOSTER_PROMPT_SEGMENTS[5]=
```

A small demo of the dummy custom prompt segment, which has been created with help of the built-in `prompt_segment()` function from Agnoster theme:
```
# prompt_segment() - Takes two arguments, background and foreground.
# Both can be omitted, rendering default background/foreground.

customize_agnoster() {
  prompt_segment 'red' '' ' ⚙ ⚡⚡⚡ ⚙  '
}
```
![Customization demo](https://github.com/apodkutin/agnoster-zsh-theme/raw/customize-prompt/agnoster_customization.gif)

# Future work

Potentially a hg or svn module based off of alien