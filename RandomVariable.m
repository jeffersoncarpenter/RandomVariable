% WIP
classdef Datum
    properties
        Value
        Variance
    end
    methods
        function obj = Datum(a, b)
            obj.Value = a;
            obj.Variance = b;
        end
        function r = plus(a, b)
            if isa(a, 'Datum')
                r = b;
                if numel(a) == numel(b)
                    for i = 1:numel(b)
                        r(i) = Datum(a(i).Value + b(i).Value, a(i).Variance + b(i).Variance);
                    end
                elseif numel(a) == 1
                    for i = 1:numel(b)
                        r(i) = Datum(a.Value + b(i).Value, a.Variance + b(i).Variance);
                    end
                else
                    for i = 1:numel(a)
                        r(i) = Datum(a(i).Value + b.Value, a(i).Variance + b.Variance);
                    end
                end
            else
                r = Datum(a + b.Value, b.Variance);
            end
        end
        function r = minus(a, b)
            r = plus(a, -1 * b);
        end
        function r = mtimes(a, b)
            % matlab's automatically making everything matrices all the
            % time is a disaster
            if isa(a, 'Datum')
                if 1 == numel(b)
                    r = a;
                    for i = 1:numel(a)
                        r(i) = Datum(a(i).Value * b.Value, a(i).Value^2 * b.Variance + a(i).Variance * b.Value^2);
                    end
                elseif (1 == numel(a))
                    r = b;
                    for i = 1:numel(b)
                        r(i) = Datum(a.Value * b(i).Value, a.Value^2 * b(i).Variance + a.Variance * b(i).Value^2);
                    end
                else
                    r = a;
                    for i = 1:numel(a)
                        r(i) = Datum(a(i).Value * b(i).Value, a(i).Value^2 * b(i).Variance + a(i).Variance * b(i).Value^2);
                    end
                end
            else
                if 1 == numel(b)
                    if 1 == numel(a)
                        r = Datum(a * b.Value, a^2 * b.Variance);
                    else
                        for i = 1:numel(a)
                            r(i) = Datum(a(i) * b.Value, a(i)^2 * b.Variance);
                        end
                    end
                else
                    r = b;
                    for i = 1:numel(b)
                        r(i) = Datum(a * b(i).Value, a^2 * b(i).Variance);
                    end
                end
            end
        end
        function r = mpower(a, b)
            if isa(a, 'Datum')
                r = a;
                for i = 1:numel(a)
                    r(i) = Datum(a(i).Value^b, b^2 * a(i).Value^(2*b-2) * a(i).Variance);
                end
            elseif isa(b, 'Datum')
                r = b;
                for i = 1:numel(b)
                    r(i) = Datum(a^b(i).Value, a^(2 * b(i).Value) * log(a)^2 * b(i).Variance);
                end
            end
        end
        function r = mrdivide(a, b)
            r = mtimes(a, b^-1);
        end
        function r = rdivide(a, b)
            r = a;
            for i = 1:numel(a)
                r(i) = a(i) / b(i);
            end
        end
        function r = log(a)
            r = a;
            for i = 1:numel(a)
                r(i) = Datum(log(a(i).Value), a(i).Variance / a(i).Value^2);
            end
        end
        function r = exp(a)
            r = a;
            for i = 1:numel(a)
                r(i) = Datum(exp(a(i).Value), exp(2*a(i).Value) * a(i).Variance);
            end
        end
        function r = variance(a)
            r = zeros(1, numel(a));
            for i = 1:numel(a)
                r(i) = a(i).Variance;
            end
        end
        function r = stdev(a)
            r = zeros(1, numel(a));
            for i = 1:numel(a)
                r(i) = sqrt(a(i).Variance);
            end
        end
        function r = value(a)
            r = zeros(1, numel(a));
            for i = 1:numel(a)
                r(i) = a(i).Value;
            end
        end
    end
end
