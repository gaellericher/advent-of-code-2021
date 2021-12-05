from os.path import join, dirname


def count_increase(l):
    n = len(l)
    c = 0
    for i in range(1, n):
        if l[i] > l[i - 1]:
            c += 1
    return c


def sum_sliding_window(l, window_size=3):
    hws = window_size // 2
    n = len(l)
    return [sum(l[i - hws:i + hws + 1]) for i in range(hws, n - hws)]


if __name__ == '__main__':
    test_lines = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
    assert (count_increase(test_lines) == 7)
    sum_test_lines = [607, 618, 618, 617, 647, 716, 769, 792]
    print(sum_sliding_window(test_lines, 3))
    assert (sum_sliding_window(test_lines, 3) == sum_test_lines)
    assert (count_increase(sum_sliding_window(test_lines, 3)) == 5)

    with open(join(dirname(__file__), "input"), "r") as f:
        actual_lines = [int(v) for v in f.readlines()]
        print(count_increase(actual_lines))
        print(count_increase(sum_sliding_window(actual_lines, window_size=3)))
