module Treasure where

import Debug.Trace
main = do
    str <- readFile("map.txt")
    putStrLn "This is my challenge:"
    putStrLn (str ++ "\n")
    let arr = lines str
    let (xx,yy) = (0,0)
    if((fst(traverse((xx,yy),arr)))==True)
      then print("Woo hoo, I found the treasure :-)")
      else print("Uh oh, I could not find the treasure :-(")
    putStr "\n"
    putStrLn $ unlines (snd(traverse((xx,yy),arr)))

writePlus :: (Int,Int,Char,[String]) -> [String]
writePlus (xx,yy,char,arr) = (take xx arr) ++((xxstr(yy,char,(arr!!xx))) : (drop (xx + 1) arr))

xxstr :: (Int,Char,String) -> String
xxstr (yy,char,arr) = take (yy) arr ++ [char] ++ drop (yy + 1) arr

valid :: (Int,Int,[String]) -> Bool
valid (xx,yy,arr)
        | xx < length (arr) && yy < length (arr !! 0) && xx >= 0 && yy >= 0 = True
        | otherwise = False

traverse :: ((Int,Int),[String]) -> (Bool,[String])
traverse ((xx,yy),arr)
        | not(valid(xx,yy,arr)) = (False,arr)
        | arr !! xx !! yy == '0' = (False,arr)
        | arr !! xx !! yy == '$' = (False,arr)
        | arr !! xx !! yy == '1' = (False,arr)
        | arr !! xx !! yy == '@' = (True,arr)
        | fst(up) = up
        | fst(right) = right
        | fst(down) = down
        | fst(left) = left
        | not(fst(left)) = (False,snd(traverse((xx-1,yy),snd(traverse((xx,yy+1),snd(traverse((xx+1,yy),writePlus(xx,yy,'$',snd(left)))))))))
            where
                up = traverse((xx-1,yy),writePlus(xx,yy,'1',arr))
                right = traverse((xx,yy+1),writePlus(xx,yy,'1',snd(up)))
                down = traverse((xx+1,yy),writePlus(xx,yy,'1',snd(right)))
                left = traverse((xx,yy-1),writePlus(xx,yy,'1',snd(down)))
