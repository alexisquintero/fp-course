{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Course.Compose where

import Course.Core
import Course.Functor
import Course.Applicative
import Course.Monad
import Course.Contravariant

-- Exactly one of these exercises will not be possible to achieve. Determine which.

newtype Compose f g a =
  Compose (f (g a)) deriving (Show, Eq)

-- Implement a Functor instance for Compose
instance (Functor f, Functor g) =>
    Functor (Compose f g) where
  f <$> Compose x = Compose ((f <$>) <$> x)
  -- f <$> Compose x = Compose (f <$> x)
  -- f <$> Compose x = Compose $ f . x
  -- f <$> Compose x = Compose $ x . f

instance (Applicative f, Applicative g) =>
  Applicative (Compose f g) where
-- Implement the pure function for an Applicative instance for Compose
  pure = Compose . pure . pure
  -- pure a = Compose $ pure . pure $ a
-- Implement the (<*>) function for an Applicative instance for Compose
  Compose f <*> Compose a = Compose (lift2 (<*>) f a)
  -- Compose f <*> Compose a = Compose $ n <*> a
  --   where n = ((<*>) <$> f)
  -- -- <$> :: (a -> b) -> k a -> k b
  -- -- m :: f (g a -> g b)
  -- -- f :: f (g (a -> b))

instance (Monad f, Monad g) =>
  Monad (Compose f g) where
-- Implement the (=<<) function for a Monad instance for Compose
  (=<<) =
    error "kinda hard"

-- Note that the inner g is Contravariant but the outer f is
-- Functor. We would not be able to write an instance if both were
-- Contravariant; why not?
instance (Functor f, Contravariant g) =>
  Contravariant (Compose f g) where
-- Implement the (>$<) function for a Contravariant instance for Compose
  f >$< Compose a = Compose ((f >$<) <$> a)
