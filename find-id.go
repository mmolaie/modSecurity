package main

import (
    "bufio"
    "fmt"
    "os"
    "regexp"
)

func main() {
    file, err := os.Open("error.log")
    if err != nil {
        fmt.Println(err)
    }
    defer file.Close()

    scanner := bufio.NewScanner(file)
    re := regexp.MustCompile(`\[id "(?P<modsecid>\d+)"\]`)

    for scanner.Scan() {
        line := scanner.Text()
        match := re.FindStringSubmatch(line)
        if len(match) > 0 {
            fmt.Println("ModSecurity ID:", match[1])
        }
    }

    if err := scanner.Err(); err != nil {
        fmt.Println(err)
    }
}
