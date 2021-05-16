# Operations Administration Management Infrastructure at TSYS Group

## Introduction

(following is copied from our systems overview document)

This is the back office IT bits.

* Functions
  * librenms (monitoring/alerting/long term metrics)
  * netdata (central dashboard)
  * upsd (central dashboard)
  * rundeck (internal orchestration only)
  * sshaudit
  * lynis
  * crash dump server
  * openvas
  * etc

  |VM Name | VM ID | Vm Host | Storage Enclosure| Storage Array |
  |---|---|---|---|--|
  |pfv-toolbox|121|vm3|stor2|tier2vm|

### The origin of the name toolbox

I can't take credit for coming up with naming a utility server toolbox. That credit goes to
the Big Gator. Back when we could freely roam, they let us s (when we could s, before I uncovered a massive federal felony and we had to take drastic action to avoid a consent decree...., I digress,  this isn't that story (buy the book!)) to toolbox. It had many fun things.

So at every employer since, I've established at least one system called toolbox. It's fitting that my startup have the same , no?

### monitoring/alerting/metrics

### orchestration

### security auditing
