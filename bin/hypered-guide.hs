-- | This program generates static HTML pages matching the content of the
-- Storybook component explorer. The generated HTML files are created in the
-- generated/ directory. They are available as production, pretty-printed, and
-- partial HTML.

{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Char (isDigit, isUpper, toLower)
import Data.List (nub)
import qualified Data.Text.Lazy.IO as T
import Text.Blaze.Html5 (Html, (!))
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A
import qualified Text.Blaze.Html.Renderer.Pretty as Pretty (renderHtml)
import Text.Blaze.Html.Renderer.Text (renderHtml)
import System.Environment (getArgs)

import Hypered.Html
  ( codeBlock, bannerGreen, bannerRed, bannerYellow
  , buttonFullWidth, buttonPrimary, buttonPrimaryDisabled, buttonSecondary
  , buttonSecondaryDisabled, defaultConfig, document
  , exampleSidebar, exampleSidePanel, footer
  , generate, nav, navigation, navigationNoteed, navigationNoteed')
import Hypered.Stories (stories)


------------------------------------------------------------------------------
main :: IO ()
main = do
  args <- getArgs
  case args of
    [] -> generateGuide

    -- The document wrapper. This should match `pages/_app.js`.
    ["wrapper"] ->
      putStr (Pretty.renderHtml
        ( document defaultConfig "wrapper.html" "Hypered Design System"
          ( H.preEscapedToHtml ("<!-- CONTENT MARKER -->" :: String)
        )))

    -- Individual components
    ["nav"] -> T.putStr (renderHtml (nav ""))
    ["footer"] -> T.putStr (renderHtml (footer "© Hypered, 2019."))

    -- Stories form Storybook
    ["navigation--navigation"] ->
      T.putStr (renderHtml (navigationNoteed))
    ["navigation--navigation-space-between"] ->
      T.putStr (renderHtml (navigationNoteed'))
    ["layout--default"] ->
      T.putStr (renderHtml (nav ""))

    ["list-categories"] -> mapM_ putStrLn (nub ((map fst (tail stories))))
    ["list-stories"] -> mapM_ putStrLn
      (map dashdash (tail stories))
    ["js-import-stories"] -> mapM_ (putStrLn . jsimport)
      (nub (map fst (tail stories)))
    ["js-stories"] -> mapM_ putStrLn
      (map js (tail stories))
    _ -> error "Unsupported argument."


------------------------------------------------------------------------------
dashdash (a, b) = map toLower (a ++ "--" ++ [head b] ++ concatMap f (tail b))
  where
  f c | isUpper c = ['-', c]
  f c | isDigit c = ['-', c]
      | otherwise = [c]

jsimport a =
  "var " ++ a ++ " = require(\"./components/" ++ a ++ "/" ++ a ++ ".stories\");"

js (a, b) = unlines
  [ "case '" ++ dashdash (a, b) ++ "':"
  , "  render(" ++ a ++ "." ++ b ++ "());"
  , "  break;"
  ]


------------------------------------------------------------------------------
generateGuide :: IO ()
generateGuide = do
  generate "index.html" "Hypered style guide" $ \_ -> do
    H.ul $ do
      H.li $ H.a ! A.href "navigation.html" $ "Navigation"

      H.li $ H.a ! A.href "banner--green.html" $ "Banner, green"
      H.li $ H.a ! A.href "banner--yellow.html" $ "Banner, yellow"
      H.li $ H.a ! A.href "banner--red.html" $ "Banner, red"

      H.li $ H.a ! A.href "button--primary.html" $ "Button, primary"
      H.li $ H.a ! A.href "button--primary-disabled.html" $ "Button, primary disabled"
      H.li $ H.a ! A.href "button--secondary.html" $ "Button, secondary"
      H.li $ H.a ! A.href "button--secondary-disabled.html" $ "Button, secondary disabled"
      H.li $ H.a ! A.href "button--full-width.html" $ "Button, full width"

      H.li $ H.a ! A.href "code-block.html" $ "Code block"

      H.li $ H.a ! A.href "example--sidebar.html" $ "Example, sidebar"
      H.li $ H.a ! A.href "example--side-panel.html" $ "Example, side panel"

      H.li $ H.a ! A.href "example--template.html" $ "Example, template"
      H.li $ H.a ! A.href "example--template-ibm-plex.html" $
        "Example, template (IBM Plex)"

  -- Horizontal navigation bar:
  -- This is mostly header / nav / a, a, ...

  generate "navigation.html" "Hypered style guide - Navigation" navigation

  -- Banner

  generate "banner--green.html" "Hypered style guide - Banner"
    (const (bannerGreen "Message sent!"))
  generate "banner--yellow.html" "Hypered style guide - Banner"
    (const (bannerYellow "Something might be wrong."))
  generate "banner--red.html" "Hypered style guide - Banner"
    (const (bannerRed "Error, something is wrong."))

  -- Button

  generate "button--primary.html" "Hypered style guide - Button"
    (const (buttonPrimary "Primary Button"))
  generate "button--primary-disabled.html" "Hypered style guide - Button"
    (const (buttonPrimaryDisabled "Primary Button"))
  generate "button--secondary.html" "Hypered style guide - Button"
    (const (buttonSecondary "Secondary Button"))
  generate "button--secondary-disabled.html" "Hypered style guide - Button"
    (const (buttonSecondaryDisabled "Secondary Button"))
  generate "button--full-width.html" "Hypered style guide - Button"
    (const (buttonFullWidth "Primary Button"))

  -- Code block

  generate "code-block.html" "Hypered style guide - Code block"
    (const codeBlock)

  -- Footer

  generate "footer.html" "Hypered style guide - Footer"
    (const (footer "© Võ Minh Thu, 2017-2019."))


  -- Example usage

  generate "example--sidebar.html" "Hypered style guide - Sidebar Example"
    (const exampleSidebar)
  generate "example--side-panel.html" "Hypered style guide - Side panel Example"
    (const exampleSidePanel)
