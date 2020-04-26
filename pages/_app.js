// This file should match the the `document` function in `Hypered/Html.hs`.
// That function can be called from the command-line as:
//
//   $ nix-shell --run "runghc bin/hypered-guide.hs wrapper"

import React from "react";
import App from "next/app";
import Head from "next/head";
import { createGlobalStyle } from "styled-components";

const GlobalStyle = createGlobalStyle`
  * {
    box-sizing: border-box;
  }

  html {
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
  }

  @supports (font-variation-settings: normal) {
    html {
      font-family: 'Inter var', -apple-system, BlinkMacSystemFont, sans-serif;
    }
  }

  body {
    background: #ffffff;
    color: #000000;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
  }
`;

export default class MyApp extends App {
  render() {
    const { Component, pageProps } = this.props;
    return (
      <>
        <Head>
          <title>Hypered Design System</title>
          <link
            rel="icon"
            type="image/png"
            href={`${process.env.BACKEND_URL}/static/img/favicon.png`}
          />
          <link rel="stylesheet" href="https://rsms.me/inter/inter.css" />
          <link
            rel="stylesheet"
            href="https://unpkg.com/tachyons@4.10.0/css/tachyons.min.css"
          />
          <link
            rel="stylesheet"
            href={`${process.env.BACKEND_URL}/static/css/styles.css`}
          />
        </Head>

        <GlobalStyle />
        <Component {...pageProps} />
      </>
    );
  }
}
