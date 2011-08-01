{-# LANGUAGE FlexibleContexts, ImpredicativeTypes, MultiParamTypeClasses, OverloadedStrings, RankNTypes #-}
{-# OPTIONS -Wall #-}
module ClarisTrans (
  Translator(..), Parenthesis(..), paren, joinBy, joinEndBy
  ) where

import           ClarisDef
import qualified Data.List as L
import qualified Data.ListLike as LL
import           Util
import           Prelude hiding ((++))

class Translator config a where
  translate :: config -> a -> Text
  

data Parenthesis = Paren | Bracket | Brace 
                 | Chevron | Chevron2 | Chevron3 
                 | Quotation | Quotation2

-- | an parenthesizer for lazy person.
paren :: Parenthesis -> Text -> Text
paren p str = prefix ++ str ++ suffix
  where
    (prefix,suffix) = case p of
      Paren      -> ("(",")")
      Bracket    -> ("[","]")
      Brace      -> ("{","}")
      Chevron    -> ("<",">")
      Chevron2   -> ("<<",">>")
      Chevron3   -> ("<<<",">>>")
      Quotation  -> ("\'","\'")
      Quotation2 -> ("\"","\"")

joinBy :: Text -> [Text] -> Text
joinBy sep xs = LL.concat $ L.intersperse sep xs
         
joinEndBy :: Text -> [Text] -> Text
joinEndBy sep xs = joinBy sep xs ++ sep

