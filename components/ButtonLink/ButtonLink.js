import React from "react";
import cx from "classnames";

export const ButtonLink = props => {
  let buttonLinkClassNames = cx(
    {
      "bg-black": props.variant === "primary",
      "b--black": props.variant === "primary",
      white: props.variant === "primary",
    },
    {
      "bg-white": props.variant === "secondary",
      "b--black": props.variant === "secondary",
      black: props.variant === "secondary",
    },
    {
      ph4: props.size === "normal",
      pv3: props.size === "normal",
      tc: props.size === "normal",
    },
    {
      ph3: props.size === "large",
      pb4: props.size === "large",
      pt3: props.size === "large",
      tl: props.size === "large",
    },
    {
      "o-50": props.disabled,
    },
    {
      "w-100": props.fullWidth || props.size === "large",
    },
    "dib",
    "no-underline",
    "ba",
    "bw1",
  );
  return (
    <a className={buttonLinkClassNames} href={props.href}>
      {props.children}
    </a>
  );
};
